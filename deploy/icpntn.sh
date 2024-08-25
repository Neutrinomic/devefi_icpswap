#!/bin/bash
dfx canister --network ic stop icpntn
dfx deploy --network ic  --argument 'record { 
    swap_id = principal "kv5pw-kyaaa-aaaag-qcyya-cai";
    target = principal "f54if-eqaaa-aaaaq-aacea-cai";
    NTN_destination_account = record {
        owner = principal "wzg4w-aiaaa-aaaal-qjnva-cai";
        subaccount = opt blob "\01\00\00\00\05\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    ICP_destination_account = record {
        owner = principal "wzg4w-aiaaa-aaaal-qjnva-cai";
        subaccount = opt blob "\01\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    reversed = false;
}' icpntn
dfx canister --network ic start icpntn
