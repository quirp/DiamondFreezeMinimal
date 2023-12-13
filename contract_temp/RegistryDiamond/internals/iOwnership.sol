pragma solidity ^0.8.9;

import "../libraries/LibOwnership.sol";

contract iOwnership {
    event OwnershipTransferred(address indexed oldOwner, address indexed newOwner);
    
    function isOwner() internal view returns (address owner_){
        LibOwnership.OwnershipStorage storage os = LibOwnership.ownershipStorage();
        owner_ = os.owner;
        require( owner_ == msg.sender, "You must be the owner of the contract");
    }
    function _setOwner(address _newOwner) internal {
        LibOwnership.OwnershipStorage storage os = LibOwnership.ownershipStorage();
        address _oldOwner = isOwner();
        os.owner == _newOwner;
        emit OwnershipTransferred(_oldOwner, _newOwner); //modifiers make this less optimized
    }
    function _getOwner() internal view returns (address owner_){ 
        LibOwnership.OwnershipStorage storage os = LibOwnership.ownershipStorage();
        owner_ = os.owner;
    }
}
