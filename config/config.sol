pragma solidity ^0.8.9;

contract Config {
    uint256 parameter1;
    address parameter2;
    uint256 parameter3;

    struct A {
        uint128 a;
        uint64 b;
        uint64 c;
        bool[] d;
    }

    A[] parameter4; 
}


/**
    We need to have Two Layouts, Contracts with their freezable dependencies and Freezables
    with their contract dependencies. 

    There would also be two App states : Current, Transition. 

    Transition in contract layout:
        Contracts show a distinct color showing non-trivial diff 
        State variables have colors for unchanged, toFrozen (ice blue), toUnfrozen (bright Orange)
    Transition in state variable layout:
        Same color schema as above 

    

 */