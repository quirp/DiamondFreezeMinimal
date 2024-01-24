pragma solidity ^0.8.0;

import "./LibType.sol";
import "./iType.sol";
contract ExternalTyping is iType {
    .function _vector() internal pure {
        return LibType.Vector(39,LibType.Coordinate(4,9));
    }

    function _dual() internal pure {
        return DualVector(9,3)
    }
}