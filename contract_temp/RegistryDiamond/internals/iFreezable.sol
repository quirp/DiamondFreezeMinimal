pragma solidity ^0.8.9;

import "../interfaces/IDiamondManage.sol";
import "../libraries/LibFreezable.sol";
import "../internals/iOwnership.sol";
contract iFreezable is iOwnership{
    enum FreezableAction {Transform, New, Remove}
    struct Freezable { 
        FreezableAction action; 
        bytes32 newStateVector;
    }
    
    function _freezableCut(Freezable memory __freezableCut, DiamondCut memory _diamondCut) internal {
        if( __freezableCut.action == FreezableAction.Transform){
            //cutOnto diamond
            //
        }
    }

}
/**
 * 2 seperate storages. (We must know which selectors exist in the freezableVersion)
 * Must check to make sure not overwriting non freezable vs freezable storage.
 * Do we need to make the freezable distinction with respect to storage?
 * Diamond already blocks selector collisions
 * 
 * Just leave the base diamond/facets as is and go straight to the freezeable?
 * 
 * Check contract dependencies before cutting. 
 * But what about normal upgrades that don't effect the freezable state? This could be a 
 * bit tricky, and would likely need to be done off-chain. 
 * 
 * Would want verification of parameter arguments on non-transformations. 
 * Every freezable contract must be verified regardless (for non-New transforms)
 * So check if diamondCut[i].facetAddress is including in freezable set.
 * If it is, revert. Otherwise enable cut. Shared storage, selector collision will be alerted. 
 * Unintentionally modifying freezable can't be done unless going through freezable external. 
 * 
 */