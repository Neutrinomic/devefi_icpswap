// This is a generated Motoko binding.
// Please use `import service "ic:canister_id"` instead to call canisters on the IC if possible.

module {
  public type AccountBalance = { balance0 : Nat; balance1 : Nat };
  public type ClaimArgs = { positionId : Nat };
  public type CycleInfo = { balance : Nat; available : Nat };
  public type DecreaseLiquidityArgs = { liquidity : Text; positionId : Nat };
  public type DepositAndMintArgs = {
    tickUpper : Int;
    fee0 : Nat;
    fee1 : Nat;
    amount0 : Nat;
    amount1 : Nat;
    positionOwner : Principal;
    amount0Desired : Text;
    amount1Desired : Text;
    tickLower : Int;
  };
  public type DepositArgs = { fee : Nat; token : Text; amount : Nat };
  public type Error = {
    #CommonError;
    #InternalError : Text;
    #UnsupportedToken : Text;
    #InsufficientFunds;
  };
  public type GetPositionArgs = { tickUpper : Int; tickLower : Int };
  public type IncreaseLiquidityArgs = {
    positionId : Nat;
    amount0Desired : Text;
    amount1Desired : Text;
  };
  public type MintArgs = {
    fee : Nat;
    tickUpper : Int;
    token0 : Text;
    token1 : Text;
    amount0Desired : Text;
    amount1Desired : Text;
    tickLower : Int;
  };
  public type Page = {
    content : [UserPositionInfoWithId];
    offset : Nat;
    limit : Nat;
    totalElements : Nat;
  };
  public type Page_1 = {
    content : [UserPositionInfoWithTokenAmount];
    offset : Nat;
    limit : Nat;
    totalElements : Nat;
  };
  public type Page_2 = {
    content : [TickInfoWithId];
    offset : Nat;
    limit : Nat;
    totalElements : Nat;
  };
  public type Page_3 = {
    content : [TickLiquidityInfo];
    offset : Nat;
    limit : Nat;
    totalElements : Nat;
  };
  public type Page_4 = {
    content : [PositionInfoWithId];
    offset : Nat;
    limit : Nat;
    totalElements : Nat;
  };
  public type Page_5 = {
    content : [(Principal, AccountBalance)];
    offset : Nat;
    limit : Nat;
    totalElements : Nat;
  };
  public type PoolMetadata = {
    fee : Nat;
    key : Text;
    sqrtPriceX96 : Nat;
    tick : Int;
    liquidity : Nat;
    token0 : Token;
    token1 : Token;
    maxLiquidityPerTick : Nat;
    nextPositionId : Nat;
  };
  public type PositionInfo = {
    tokensOwed0 : Nat;
    tokensOwed1 : Nat;
    feeGrowthInside1LastX128 : Nat;
    liquidity : Nat;
    feeGrowthInside0LastX128 : Nat;
  };
  public type PositionInfoWithId = {
    id : Text;
    tokensOwed0 : Nat;
    tokensOwed1 : Nat;
    feeGrowthInside1LastX128 : Nat;
    liquidity : Nat;
    feeGrowthInside0LastX128 : Nat;
  };
  public type PushError = { time : Int; message : Text };
  public type Result = { #ok : Nat; #err : Error };
  public type Result_1 = { #ok : Text; #err : Error };
  public type Result_10 = { #ok : Page_1; #err : Error };
  public type Result_11 = { #ok : [Nat]; #err : Error };
  public type Result_12 = { #ok : [(Text, [Nat])]; #err : Error };
  public type Result_13 = { #ok : UserPositionInfo; #err : Error };
  public type Result_14 = { #ok : [TransferLog]; #err : Error };
  public type Result_15 = {
    #ok : {
      swapFee0Repurchase : Nat;
      token0Amount : Nat;
      swapFeeReceiver : Text;
      token1Amount : Nat;
      swapFee1Repurchase : Nat;
    };
    #err : Error;
  };
  public type Result_16 = { #ok : Page_2; #err : Error };
  public type Result_17 = { #ok : Page_3; #err : Error };
  public type Result_18 = {
    #ok : {
      infoCid : Text;
      records : [SwapRecordInfo];
      errors : [PushError];
      retryCount : Nat;
    };
    #err : Error;
  };
  public type Result_19 = { #ok : Page_4; #err : Error };
  public type Result_2 = { #ok : Bool; #err : Error };
  public type Result_20 = { #ok : PositionInfo; #err : Error };
  public type Result_21 = { #ok : CycleInfo; #err : Error };
  public type Result_22 = {
    #ok : { amount0 : Nat; amount1 : Nat };
    #err : Error;
  };
  public type Result_23 = {
    #ok : {
      tokenIncome : [(Nat, { tokensOwed0 : Nat; tokensOwed1 : Nat })];
      totalTokensOwed0 : Nat;
      totalTokensOwed1 : Nat;
    };
    #err : Error;
  };
  public type Result_24 = { #ok : Page_5; #err : Error };
  public type Result_3 = { #ok : Int; #err : Error };
  public type Result_4 = {
    #ok : { tokensOwed0 : Nat; tokensOwed1 : Nat };
    #err : Error;
  };
  public type Result_5 = { #ok : PoolMetadata; #err : Error };
  public type Result_6 = { #ok : [(Nat, WithdrawErrorLog)]; #err : Error };
  public type Result_7 = {
    #ok : { balance0 : Nat; balance1 : Nat };
    #err : Error;
  };
  public type Result_8 = { #ok : [UserPositionInfoWithId]; #err : Error };
  public type Result_9 = { #ok : Page; #err : Error };
  public type SwapArgs = {
    amountIn : Text;
    zeroForOne : Bool;
    amountOutMinimum : Text;
  };
  public type SwapRecordInfo = {
    to : Text;
    feeAmount : Int;
    action : TransactionType;
    feeAmountTotal : Int;
    token0Id : Text;
    token1Id : Text;
    token0AmountTotal : Nat;
    liquidityTotal : Nat;
    from : Text;
    tick : Int;
    feeTire : Nat;
    recipient : Text;
    token0ChangeAmount : Nat;
    token1AmountTotal : Nat;
    liquidityChange : Nat;
    token1Standard : Text;
    TVLToken0 : Int;
    TVLToken1 : Int;
    token0Fee : Nat;
    token1Fee : Nat;
    timestamp : Int;
    token1ChangeAmount : Nat;
    token0Standard : Text;
    price : Nat;
    poolId : Text;
  };
  public type TickInfoWithId = {
    id : Text;
    initialized : Bool;
    feeGrowthOutside1X128 : Nat;
    secondsPerLiquidityOutsideX128 : Nat;
    liquidityNet : Int;
    secondsOutside : Nat;
    liquidityGross : Nat;
    feeGrowthOutside0X128 : Nat;
    tickCumulativeOutside : Int;
  };
  public type TickLiquidityInfo = {
    tickIndex : Int;
    price0Decimal : Nat;
    liquidityNet : Int;
    price0 : Nat;
    price1 : Nat;
    liquidityGross : Nat;
    price1Decimal : Nat;
  };
  public type Token = { address : Text; standard : Text };
  public type TransactionType = {
    #decreaseLiquidity;
    #claim;
    #swap;
    #addLiquidity;
    #increaseLiquidity;
  };
  public type TransferLog = {
    to : Principal;
    fee : Nat;
    result : Text;
    token : Token;
    action : Text;
    daysFrom19700101 : Nat;
    owner : Principal;
    from : Principal;
    fromSubaccount : ?Blob;
    timestamp : Nat;
    index : Nat;
    amount : Nat;
    errorMsg : Text;
  };
  public type UserPositionInfo = {
    tickUpper : Int;
    tokensOwed0 : Nat;
    tokensOwed1 : Nat;
    feeGrowthInside1LastX128 : Nat;
    liquidity : Nat;
    feeGrowthInside0LastX128 : Nat;
    tickLower : Int;
  };
  public type UserPositionInfoWithId = {
    id : Nat;
    tickUpper : Int;
    tokensOwed0 : Nat;
    tokensOwed1 : Nat;
    feeGrowthInside1LastX128 : Nat;
    liquidity : Nat;
    feeGrowthInside0LastX128 : Nat;
    tickLower : Int;
  };
  public type UserPositionInfoWithTokenAmount = {
    id : Nat;
    tickUpper : Int;
    tokensOwed0 : Nat;
    tokensOwed1 : Nat;
    feeGrowthInside1LastX128 : Nat;
    liquidity : Nat;
    feeGrowthInside0LastX128 : Nat;
    token0Amount : Nat;
    token1Amount : Nat;
    tickLower : Int;
  };
  public type Value = { #Int : Int; #Nat : Nat; #Blob : Blob; #Text : Text };
  public type WithdrawArgs = { fee : Nat; token : Text; amount : Nat };
  public type WithdrawErrorLog = {
    token : Token;
    time : Int;
    user : Principal;
    amount : Nat;
  };
  public type Self = actor {
    allTokenBalance : shared query (Nat, Nat) -> async Result_24;
    approvePosition : shared (Principal, Nat) -> async Result_2;
    batchRefreshIncome : shared query [Nat] -> async Result_23;
    checkOwnerOfUserPosition : shared query (Principal, Nat) -> async Result_2;
    claim : shared ClaimArgs -> async Result_22;
    decreaseLiquidity : shared DecreaseLiquidityArgs -> async Result_22;
    deposit : shared DepositArgs -> async Result;
    depositAllAndMint : shared DepositAndMintArgs -> async Result;
    depositFrom : shared DepositArgs -> async Result;
    getAdmins : shared query () -> async [Principal];
    getAvailabilityState : shared query () -> async {
        whiteList : [Principal];
        available : Bool;
      };
    getClaimLog : shared query () -> async [Text];
    getCycleInfo : shared () -> async Result_21;
    getMistransferBalance : shared Token -> async Result;
    getPosition : shared query GetPositionArgs -> async Result_20;
    getPositions : shared query (Nat, Nat) -> async Result_19;
    getSwapRecordState : shared query () -> async Result_18;
    getTickInfos : shared query (Nat, Nat) -> async Result_17;
    getTicks : shared query (Nat, Nat) -> async Result_16;
    getTokenAmountState : shared query () -> async Result_15;
    getTokenBalance : shared () -> async { token0 : Nat; token1 : Nat };
    getTokenMeta : shared () -> async {
        token0 : [(Text, Value)];
        token1 : [(Text, Value)];
      };
    getTransferLogs : shared query () -> async Result_14;
    getUserByPositionId : shared query Nat -> async Result_1;
    getUserPosition : shared query Nat -> async Result_13;
    getUserPositionIds : shared query () -> async Result_12;
    getUserPositionIdsByPrincipal : shared query Principal -> async Result_11;
    getUserPositionWithTokenAmount : shared query (Nat, Nat) -> async Result_10;
    getUserPositions : shared query (Nat, Nat) -> async Result_9;
    getUserPositionsByPrincipal : shared query Principal -> async Result_8;
    getUserUnusedBalance : shared query Principal -> async Result_7;
    getVersion : shared query () -> async Text;
    getWithdrawErrorLog : shared query () -> async Result_6;
    increaseLiquidity : shared IncreaseLiquidityArgs -> async Result;
    init : shared (Nat, Int, Nat) -> async ();
    metadata : shared query () -> async Result_5;
    mint : shared MintArgs -> async Result;
    quote : shared query SwapArgs -> async Result;
    quoteForAll : shared query SwapArgs -> async Result;
    refreshIncome : shared query Nat -> async Result_4;
    removeErrorTransferLog : shared (Nat, Bool) -> async ();
    removeWithdrawErrorLog : shared (Nat, Bool) -> async ();
    resetTokenAmountState : shared (Nat, Nat, Nat, Nat) -> async ();
    setAdmins : shared [Principal] -> async ();
    setAvailable : shared Bool -> async ();
    setWhiteList : shared [Principal] -> async ();
    sumTick : shared query () -> async Result_3;
    swap : shared SwapArgs -> async Result;
    transferPosition : shared (Principal, Principal, Nat) -> async Result_2;
    upgradeTokenStandard : shared Principal -> async Result_1;
    withdraw : shared WithdrawArgs -> async Result;
    withdrawMistransferBalance : shared Token -> async Result;
  }
}