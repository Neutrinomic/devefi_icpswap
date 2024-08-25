#!/bin/bash
dfx canister --network ic stop icpckbtc
dfx deploy --network ic  --argument 'record { 
    swap_id = principal "xmiu5-jqaaa-aaaag-qbz7q-cai";
    target = principal "mxzaz-hqaaa-aaaar-qaada-cai";
    NTN_destination_account = record {
        owner = principal "wqfxk-waaaa-aaaal-qjnuq-cai";
        subaccount = opt blob "\01\00\00\00\08\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    ICP_destination_account = record {
        owner = principal "wqfxk-waaaa-aaaal-qjnuq-cai";
        subaccount = opt blob "\01\00\00\00\07\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    reversed = false;
}' icpckbtc
dfx canister --network ic start icpckbtc