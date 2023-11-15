pragma solidity ^0.8.9;

import "../libraries/LibA.sol";

contract iParameter1 {
    function _getParameter1() internal view returns (uint256) {
        return LibA._getParameter1();
    }
}
