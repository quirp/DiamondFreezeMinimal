pragma solidity ^0.8.9;

import "../internals/iSecond.sol";
import "../libraries/Lib2.sol";

contract Second is iSecond{
    constructor(address owner) iSecond(owner){}
    function getFunction2() external view returns (address){
        _getFunction();
    }
    function setFunction2(address _parameter2) external {
        LibB._setParameter2(_parameter2);
    }
}