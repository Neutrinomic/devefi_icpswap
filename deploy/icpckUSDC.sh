#!/bin/bash
dfx canister --network ic stop icpckusdc
dfx deploy --network ic  --argument 'record { 
    swap_id = principal "mohjv-bqaaa-aaaag-qjyia-cai";
    target = principal "xevnm-gaaaa-aaaar-qafnq-cai";
    NTN_destination_account = record {
        owner = principal "mwdpu-4yaaa-aaaal-qjqhq-cai";
        subaccount = opt blob "\01\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    ICP_destination_account = record {
        owner = principal "mwdpu-4yaaa-aaaal-qjqhq-cai";
        subaccount = opt blob "\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    reversed = true;
}' icpckusdc
dfx canister --network ic start icpckusdc
