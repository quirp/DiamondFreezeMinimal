pragma solidity ^0.8.9;

import "../interfaces/IDiamondManage.sol";
import "../libraries/LibFreezable.sol";
import "../internals/iOwnership.sol";
contract iFreezable is iOwnership{
    enum FreezableAction {Transform, New, Remove}
    struct Freezable { 
        FreezableAction action; 
        bytes32 newStateVector;
        address newFreezableAddress;
    }
    
    function _freezableCut(Freezable memory __freezableCut, DiamondCut memory _diamondCut) internal {
        if( __freezableCut.action == FreezableAction.Transform){
            //cutOnto diamond
            //
        }
    }

}
