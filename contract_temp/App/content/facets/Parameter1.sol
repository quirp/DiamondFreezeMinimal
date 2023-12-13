pragma solidity ^0.8.9;

import "../internals/iParameter1.sol";
import "../libraries/Lib1.sol";

contract First is iFirst{
    function getParameter1() external view returns (uint256){
        _getParameter1();
    }
    function setParameter1(uint256 _parameter1) external {
        LibA._setParameter1(_parameter1);
    }
}