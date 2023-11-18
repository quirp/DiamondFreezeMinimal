pragma solidity ^0.8.9;


library LibB {

    bytes32 constant LibB_STORAGE_POSITION = keccak256("diamond.storage.LibB");

    struct LibBStorage{
        //..
        address parameter2;

        //...
    }

    function libBStorage() internal pure returns ( LibBStorage storage ls){
        bytes32 storage_slot = LibB_STORAGE_POSITION;
        assembly{
            ls.slot := storage_slot
        }
    }
    function _getParameter2() internal view returns( address ){
        return libBStorage().parameter2;
    }
    function _setParameter2(address _parameter2) internal{
        LibBStorage storage ls = libBStorage();
        ls.parameter2 = _parameter2;
    }
}