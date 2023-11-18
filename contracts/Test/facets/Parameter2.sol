pragma solidity ^0.8.9;

import "../internals/iParameter2.sol";
import "../libraries/LibB.sol";

contract Parameter2 is iParameter2{
    constructor(address owner) iParameter2(owner){}
    function getParameter2() external view returns (address){
        _getParameter2();
    }
    function setParameter2(address _parameter2) external {
        LibB._setParameter2(_parameter2);
    }
}