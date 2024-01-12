pragma solidity ^0.8.9;

import "../internals/iB.sol";
import "../libraries/LibB.sol";

contract Second is iSecond {
    constructor(address owner) iSecond(owner) {}

    function getFunction2() external view returns (address) {
        _getFunction();
    }

    function setFunction2(address _parameter2) external {
        Lib2._setParameter2(_parameter2);
    }
}
