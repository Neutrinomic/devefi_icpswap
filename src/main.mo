import L "mo:devefi-icrc-ledger";
import LICP "mo:devefi-icp-ledger";
import Principal "mo:base/Principal";
import Blob "mo:base/Blob";

import ICPSWAP "./icpswap";
import ICRCLedger "mo:devefi-icrc-ledger/icrc_ledger";
import ICPLedger "mo:devefi-icp-ledger/icp_ledger";
import U "./utils";
import Timer "mo:base/Timer";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Syslog "./syslog";
import Error "mo:base/Error";

actor class({
    swap_id : Principal;
    target: Principal;
    NTN_destination_account: ICRCLedger.Account;
    ICP_destination_account: ICPLedger.Account;
    reversed : Bool;
}) = this {

    let tokenTarget =  Principal.toText(target);
    let tokenICP = "ryjl3-tyaaa-aaaaa-aaaba-cai";
    // let swap_id = Principal.fromText("kv5pw-kyaaa-aaaag-qcyya-cai");

    // let NTN_destination_account : ICRCLedger.Account = switch(Account.fromText("wzg4w-aiaaa-aaaal-qjnva-cai-viuncya.100000005000000000000000000000000000000000000000000000000000000")) { case (#ok(a)) a; case (#err(e)) Debug.trap("Bad account " # debug_show(e)); };
    // let ICP_destination_account : ICPLedger.Account = switch(Account.fromText("wzg4w-aiaaa-aaaal-qjnva-cai-voosy7i.100000004000000000000000000000000000000000000000000000000000000")) { case (#ok(a)) a; case (#err(e)) Debug.trap("Bad account" # debug_show(e)); };


    stable let syslog_mem = Syslog.Mem();
    let syslog = Syslog.SysLog({mem = syslog_mem});

    let swap_addr = Principal.toLedgerAccount(swap_id, null);

    stable let lmem = L.LMem(); 
    let ledger = L.Ledger(lmem, tokenTarget, #last); 
    
    stable let lmemICP = LICP.LMem(); 

    let ledgerICP = LICP.Ledger(lmemICP, tokenICP, #last); 
    
    let swap = actor(Principal.toText(swap_id)) : ICPSWAP.Self;

    ledger.onReceive(func (t) {
        //VINT: Get vector principal from the account and vector destination account from subaccount
        syslog.add("LedgerTarget onReceive: " # debug_show(t));

        if (t.amount < ledger.getFee()*10) return;

        // Receive from icpswap
        if (t.from.owner == swap_id) {
            // send to destination account
            ignore ledger.send({ to = NTN_destination_account; amount = t.amount; from_subaccount = null; });
            return;
        };

        // Send to icpswap
        let amount = t.amount;
        let swap_deposit_account = {owner = swap_id; subaccount = ?U.callerSubaccount(ledger.me())};
        //VINT: Put in memo both the vector principal and destination subaccount 
        ignore ledger.send({ to = swap_deposit_account; amount; from_subaccount = t.to.subaccount; });
       
    });

    ledgerICP.onReceive(func (t) {
        syslog.add("LedgerICP onReceive: " # debug_show(t));
  
        if (t.amount < ledgerICP.getFee()*10) return;

        // Receive from icpswap
        if (t.from == swap_addr) {
            // send to destination account
            ignore ledgerICP.send({ to = ICP_destination_account; amount = t.amount; from_subaccount = null; });
            return;
        };

        // Send to icpswap
        let amount = t.amount;
        let swap_deposit_account = {owner = swap_id; subaccount = ?U.callerSubaccount(ledger.me())};
        ignore ledgerICP.send({ to = swap_deposit_account; amount; from_subaccount = null; });
       
    });

    public type TXSWAP = {
        tokenFrom : Text;
        tokenTo : Text;
        amount : Nat;
        feeFrom : Nat;
        feeTo : Nat;
    };

    stable var txqueue = List.nil<TXSWAP>();

    private func swapThat(t: TXSWAP) : async () {
                try {
                let depresp = await swap.deposit({
                    token = t.tokenFrom;
                    amount = t.amount;
                    fee = t.feeFrom;
                });
                let #ok(deposited) = depresp else { syslog.add("Deposit error " # debug_show(depresp)); return; };
                syslog.add("Deposit resp " # debug_show(depresp));
                syslog.add("Swap " # debug_show(t));
                var zeroForOne = if (t.tokenFrom == tokenTarget) (if (reversed) false else true) else (if (reversed) true else false);
                
                let resp = await swap.swap({
                    amountIn = Nat.toText(deposited);
                    zeroForOne;
                    amountOutMinimum = "0";
                });
                syslog.add("Swap resp: " # debug_show(resp));

                switch(resp) {
                    case (#ok(swappedamount)) {
                        syslog.add("Withdraw start");
                        let wresp = await swap.withdraw({
                            fee = t.feeTo;
                            amount = swappedamount;
                            token = t.tokenTo;
                        });
                        syslog.add("Withdraw resp " # debug_show(wresp));
                    };
                    case (#err(_)) {
                        return;
                    }
                }
                } catch (e) {
                    syslog.add("Swap error " # debug_show(Error.message(e)));
                }
    };

    ledger.onSent(func (t) {
        syslog.add("LedgerTarget onSent: " # debug_show(t));
        let swap_deposit_account = {owner = swap_id; subaccount = ?U.callerSubaccount(ledger.me())};
        if (t.to == swap_deposit_account) {

            txqueue := List.push({
                tokenFrom = tokenTarget;
                tokenTo = tokenICP;
                amount = t.amount;
                feeFrom = ledger.getFee();
                feeTo = ledgerICP.getFee();
            }, txqueue);

        };
    });
    
     ledgerICP.onSent(func (t) {
        syslog.add("LedgerICP onSent: " # debug_show(t));

        let swap_deposit_account = {owner = swap_id; subaccount = ?U.callerSubaccount(ledgerICP.me())};
        if (t.to == Principal.toLedgerAccount(swap_deposit_account.owner, swap_deposit_account.subaccount)) {

            txqueue := List.push({
                tokenFrom = tokenICP;
                tokenTo = tokenTarget;
                amount = t.amount;
                feeFrom = ledgerICP.getFee();
                feeTo = ledger.getFee();
            }, txqueue);


        };
    });

    ledger.start<system>();
    ledgerICP.start<system>();

    public query func getAddress() : async {swap:Blob; my:Blob} {
        let swap_deposit_account = {owner = swap_id; subaccount = ?U.callerSubaccount(ledger.me())};
        {
            swap = Principal.toLedgerAccount(swap_deposit_account.owner, swap_deposit_account.subaccount);
            my = Principal.toLedgerAccount(ledger.me(), null)
        }
    };

    public func getQuote() : async () {
        let quote = await swap.quote({
            amountIn = "";
            zeroForOne = false;
            amountOutMinimum = "0";
        })
    };

    private func cycle() : async () {
        label tasks while (true) {
            let r = List.pop(txqueue);
            txqueue := r.1;
            let ?arg = r.0 else break tasks;
            syslog.add("Running task");
            ignore swapThat(arg);
        };

        ignore Timer.setTimer<system>(#seconds 2, cycle);
    };

    ignore Timer.setTimer<system>(#seconds 2, cycle);

    public shared({caller}) func start() : async () {
        assert(Principal.isController(caller));
        ledger.setOwner(this);
        ledgerICP.setOwner(this);
    };



    public shared({caller}) func giveback() : async () { // Used during testing
        assert(Principal.isController(caller));
        ignore ledger.send({ to = NTN_destination_account; from_subaccount=null; amount = ledger.balance(null); });
        ignore ledgerICP.send({ to = ICP_destination_account; subaccount=null; from_subaccount=null; amount = ledgerICP.balance(null); });
    };


    public query ({caller}) func getInfo() : async (L.Info, L.Info) { 
        assert(Principal.isController(caller));
        (ledger.getInfo(), ledgerICP.getInfo())
    };

    public query ({caller}) func getErrors() : async ([Text],[Text]) {
        assert(Principal.isController(caller));
        (ledger.getErrors(), ledgerICP.getErrors())
    };

    public query ({caller}) func getSyslog() : async [?Text] {
        assert(Principal.isController(caller));

        syslog.get();
    }

}