pragma solidity ^0.8.9;


library Lib3 {

    bytes32 constant LibB_STORAGE_POSITION = keccak256("diamond.storage.Lib3");

    struct LibBStorage{
        //..
        bytes4 parameter3;

        //...
    }

    function lib3Storage() internal pure returns ( LibBStorage storage ls){
        bytes32 storage_slot = LibB_STORAGE_POSITION;
        assembly{
            ls.slot := storage_slot
        }
    }
    function _getParameter3() internal view returns( bytes4 ){
        return lib3Storage().parameter3;
    }
    function _setParameter3(bytes4 _parameter3) internal{
        LibBStorage storage ls = lib3Storage();
        ls.parameter3 = _parameter3;
    }
}