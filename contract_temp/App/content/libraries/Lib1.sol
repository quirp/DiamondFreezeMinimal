pragma solidity ^0.8.9;


library Lib1 {

    bytes32 constant LIB1_STORAGE_POSITION = keccak256("diamond.storage.liba");

    struct Lib1Storage{
        //..
        uint256 parameter1;

        //...
    }

    function libAStorage() internal pure returns ( Lib1Storage storage ls){
        bytes32 storage_slot = LIB1_STORAGE_POSITION;
        assembly{
            ls.slot := storage_slot
        }
    }
    function _getParameter1() internal view returns( uint256 ){
        return libAStorage().parameter1;
    }
    function _setParameter1(uint256 _parameter1) internal{
        Lib1Storage storage ls = libAStorage();
        ls.parameter1 = _parameter1;
    }
}