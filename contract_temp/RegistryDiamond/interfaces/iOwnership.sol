pragma solidity ^0.8.9;

import "../libraries/LibOwnership.sol";

contract iOwnership {
    event OwnershipTransferred(address indexed oldOwner, address indexed newOwner);
    
    function isOwner() internal view{
        LibOwnership.OwnershipStorage storage os = LibOwnership.ownershipStorage();
        require( msg.sender == os.owner, "You must be the owner of the contract");
    }
    
    function _setOwner(address _newOwner) internal {
        LibOwnership.OwnershipStorage storage os = LibOwnership.ownershipStorage();
        address _oldOwner = os.owner;
        isOwner();
        os.owner == _newOwner;
        emit OwnershipTransferred(_oldOwner, _newOwner); //onlyOwner modifiers make this less optimized
    }
    function _getOwner() internal view returns (address owner_){ 
        LibOwnership.OwnershipStorage storage os = LibOwnership.ownershipStorage();
        owner_ = os.owner;
    }
}
