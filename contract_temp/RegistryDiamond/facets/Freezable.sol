pragma solidity ^0.8.9;

import "../internals/iFreezable.sol";


contract Freezable is iFreezable{

    function freezableCut( FreezableCut memory _freezableCut) external{
        _freezableCut(_freezableCut);
    }
}