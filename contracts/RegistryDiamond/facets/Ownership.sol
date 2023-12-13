pragma solidity ^0.8.9;

import "../internals/iOwnership.sol";
import "../libraries/LibOwnership.sol";

contract Ownership is iOwnership{
    function getOwner() external view returns (address owner_){
        owner_ = _getOwner();
    }
    function setOwner(address _newOwner) external {
        _setOwner(_newOwner);
    }
}