pragma solidity ^0.8.9;


library Lib2 {
    bytes32 constant LIB2_STORAGE_POSITION = keccak256("diamond.storage.Lib2");
    struct Lib2Storage{  
        address parameter2;
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
contract iSecond {
    address immutable owner;

    constructor(address _owner) {
        owner = _owner;
    }
    function _getFunction() internal view returns (address) {
        return Lib2._getParameter2();
    }
}
contract Second is iSecond {
    constructor(address owner) iSecond(owner) {}

    function getFunction2() external view returns (address) {
        _getFunction();
    }

    function setFunction2(address _parameter2) external {
        Lib2._setParameter2(_parameter2);
    }
}