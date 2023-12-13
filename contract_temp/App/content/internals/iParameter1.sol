pragma solidity ^0.8.9;

import "../libraries/Lib1.sol";

contract iFirst{
    function _getParameter1() internal view returns (uint256) {
        return Lib1._getParameter1();
    }
}
