pragma solidity ^0.8.9;

import "../libraries/LibOwnership.sol";
contract iOwnership{
    function _getOwner() external view returns (address owner_){
        LibOwnership.OwnershipStorage storage os = LibOwnershipStorage.ownershipStorage();
        owner_ = os.owner;
    }
}