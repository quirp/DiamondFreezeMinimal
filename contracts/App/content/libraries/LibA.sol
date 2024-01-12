pragma solidity ^0.8.9;


library LibA {

    bytes32 constant LIBA_STORAGE_POSITION = keccak256("diamond.storage.LibA");

    struct LibAStorage{
        //..
        uint256 marketFee;

        //...
    }

    function libAStorage() internal pure returns ( LibAStorage storage ls){
        bytes32 storage_slot = LIBA_STORAGE_POSITION;
        assembly{
            ls.slot := storage_slot
        }
    }
    function _getMarketFee() internal view returns( uint256 ){
        return libAStorage().marketFee;
    }
    function _setMarketFee(uint256 _marketFee) internal{
        LibAStorage storage ls = libAStorage();
        ls.marketFee = _marketFee;
    }
}