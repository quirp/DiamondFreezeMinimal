pragma solidity ^0.8.9;

import "../libraries/LibA.sol";

abstract contract Freezeable1 {
    function _getFreezeable1() internal view virtual returns (uint256);

    function _getFreezeable1UF() internal view returns (uint256) {
        return LibA._getFreezeable1();
    }
}
