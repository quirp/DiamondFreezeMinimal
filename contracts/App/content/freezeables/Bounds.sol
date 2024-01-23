pragma solidity ^0.8.9;

import "../libraries/LibC.sol";

abstract contract Bounds {
    struct Bound{
        uint8[2] bounds;
        bool active;
    }
    function _getBound() internal view virtual returns (Bound memory);

    function _getBoundsUF() internal view returns (Bound memory) {
        return LibC._getBound();
    }
}
