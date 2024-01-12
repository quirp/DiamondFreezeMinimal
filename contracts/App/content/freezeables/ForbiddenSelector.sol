pragma solidity ^0.8.9;

import "../libraries/LibC.sol";

abstract contract ForbiddenSelector {
    function _getForbiddenSelector() internal view virtual returns (bytes4);

    function _getForbiddenSelectorUF() internal view returns (bytes4) {
        return LibC._getForbiddenSelector();
    }
}
