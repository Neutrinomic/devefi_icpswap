#!/bin/bash
dfx canister --network ic stop icpsneed
dfx deploy --network ic  --argument 'record { 
    swap_id = principal "osyzs-xiaaa-aaaag-qc76q-cai";
    target = principal "hvgxa-wqaaa-aaaaq-aacia-cai";
    NTN_destination_account = record {
        owner = principal "om7hi-ciaaa-aaaal-qjqiq-cai";
        subaccount = opt blob "\01\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    ICP_destination_account = record {
        owner = principal "om7hi-ciaaa-aaaal-qjqiq-cai";
        subaccount = opt blob "\01\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00";
      };
    reversed = false;
}' icpsneed
dfx canister --network ic start icpsneed


