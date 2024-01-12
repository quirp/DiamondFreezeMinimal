pragma solidity ^0.8.9;


library LibB {

    bytes32 constant LIBB_STORAGE_POSITION = keccak256("diamond.storage.LibB");

    struct LibBStorage{
        //..
        address owner;

        //...
    }

    function libBStorage() internal pure returns ( LibBStorage storage ls){
        bytes32 storage_slot = LIBB_STORAGE_POSITION;
        assembly{
            ls.slot := storage_slot
        }
    }
    function _getOwner() internal view returns (address){
        return libBStorage().owner;
    }
    function _setOwner(address _newOwner) internal {
        libBStorage().owner = _newOwner;
    }
}