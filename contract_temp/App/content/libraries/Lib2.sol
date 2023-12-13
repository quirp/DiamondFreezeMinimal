pragma solidity ^0.8.9;


library Lib2 {

    bytes32 constant LIB2_STORAGE_POSITION = keccak256("diamond.storage.Lib2");

    struct Lib2Storage{
        //..
        address parameter2;

        //...
    }

    function lib2Storage() internal pure returns ( Lib2Storage storage ls){
        bytes32 storage_slot = LIB2_STORAGE_POSITION;
        assembly{
            ls.slot := storage_slot
        }
    }
    function _getParameter2() internal view returns( address ){
        return lib2Storage().parameter2;
    }
    function _setParameter2(address _parameter2) internal{
        Lib2Storage storage ls = lib2Storage();
        ls.parameter2 = _parameter2;
    }
}