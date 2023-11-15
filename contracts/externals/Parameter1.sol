pragma solidity ^0.8.9;

import "../internals/iParameter1.sol";
import "../libraries/LibA.sol";

contract Parameter1 is iParameter1{
    function getParameter1() external view returns (uint256){
        _getParameter1();
    }
    function setParameter1(uint256 _parameter1) external view {
        LibA._setParameter1(_parameter1);
    }
}