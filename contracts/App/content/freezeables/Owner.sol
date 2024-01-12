pragma solidity ^0.8.9;

import "../libraries/LibB.sol";

abstract contract Owner {
    function _getOwner() internal view virtual returns (address);

    function _getOwnerUF() internal view returns (address) {
        return LibB._getOwner();
    }
}
