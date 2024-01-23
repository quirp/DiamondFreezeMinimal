pragma solidity ^0.8.9;

import "../freezeables/Bounds.sol";
library LibC {

    bytes32 constant LIBC_STORAGE_POSITION = keccak256("diamond.storage.LibC");

    struct LibCStorage{
        //.. other storage
        bytes4 forbiddenSelector;
        Bounds.Bound bound;
        //...
    }

    function libCStorage() internal pure returns ( LibCStorage storage ls){
        bytes32 storage_slot = LIBC_STORAGE_POSITION;
        assembly{
            ls.slot := storage_slot
        }
    }
    
    function _getForbiddenSelector() internal view returns (bytes4) {
        return libCStorage().forbiddenSelector;
    }
    function _setForbiddenSelector(bytes4 _newForbiddenSelector) internal {
        libCStorage().forbiddenSelector = _newForbiddenSelector;
    }
   
   function _getBound() internal view returns (Bounds.Bound memory) {
        return libCStorage().bound;
    }
    function _setBound(Bounds.Bound memory _newBound) internal {
        libCStorage().bound = _newBound;
    }
}