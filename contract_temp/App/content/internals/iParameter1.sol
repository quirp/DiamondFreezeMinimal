pragma solidity ^0.8.9;

import "../libraries/Lib1.sol";

contract iFirst{
    uint256 constant a = 3;
    function _getParameter1() internal view returns (uint256) {
        return Lib1._getParameter1();
    }
    function _getParameter1() private view returns (uint256) {
        return a;
    }

    function
    function _getParameter1() private view returns (uint256) {
        return a;
    }
}
/**
 * store the un-frozen function as a seperate name, private. 
 * frozen function is removed as it can be generated. 
 * can use a top layer function if needed. 
 * 
 * 
 */