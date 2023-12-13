pragma solidity ^0.8.9;

import "../internals/iFreezable.sol";
import "../libraries/LibDiamond.sol";

contract Freezable is iFreezable{

    function freezableCut( Freezable memory _freezableCut) external{
        //
        _freezableCut(_freezableCut);
    }
}