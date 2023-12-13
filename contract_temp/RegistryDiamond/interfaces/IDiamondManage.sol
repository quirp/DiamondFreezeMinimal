pragma solidity ^0.8.9;

interface IDiamondManage{
    enum FacetCutAction {Add, Replace, Remove}
    struct FacetCut {
        address facetAddress;
        FacetCutAction action;
        bytes4[] functionSelectors;
    }

    enum FreezableAction {None,Transform, New, Remove}
    struct Freezable { 
        FreezableAction action; 
        bytes32 newStateVector;
        address newFreezableAddress;
    }
    
    function diamondManage(FacetCut[] memory _facetCut, address _init, bytes calldata _data, Freezable memory _freezable) external;
}