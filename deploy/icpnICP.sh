#!/bin/bash
dfx canister --network ic stop icpnicp
dfx deploy --network ic  --argument 'record { 
    swap_id = principal "e5a7x-pqaaa-aaaag-qkcga-cai";
    target = principal "buwm7-7yaaa-aaaar-qagva-cai";
    NTN_destination_account = record {
        owner = principal "ol6b4-pqaaa-aaaal-qjqia-cai";
        subaccount = opt blob "\01\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    ICP_destination_account = record {
        owner = principal "ol6b4-pqaaa-aaaal-qjqia-cai";
        subaccount = opt blob "\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    reversed = false;
}' icpnicp
dfx canister --network ic start icpnicp