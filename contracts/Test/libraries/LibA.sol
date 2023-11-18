pragma solidity ^0.8.9;


library LibA {

    bytes32 constant LIBA_STORAGE_POSITION = keccak256("diamond.storage.liba");

    struct LibAStorage{
        //..
        uint256 parameter1;

        //...
    }

    function libAStorage() internal pure returns ( LibAStorage storage ls){
        bytes32 storage_slot = LIBA_STORAGE_POSITION;
        assembly{
            ls.slot := storage_slot
        }
    }
    function _getParameter1() internal view returns( uint256 ){
        return libAStorage().parameter1;
    }
    function _setParameter1(uint256 _parameter1) internal{
        LibAStorage storage ls = libAStorage();
        ls.parameter1 = _parameter1;
    }
}