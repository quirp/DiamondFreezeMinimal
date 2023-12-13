pragma solidity ^0.8.9;

import "../internals/iOwnership.sol";
import "../libraries/LibOwnership.sol";
contract Ownership is iOwnership{
    
    function setOwner(address _owner) external {
        _setOwner(_owner);
    }
    function getOwner() external view returns(address owner_){
        owner_ = _getOwner();
    }
}