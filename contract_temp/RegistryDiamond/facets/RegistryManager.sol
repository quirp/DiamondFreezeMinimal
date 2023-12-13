pragma solidity ^0.8.9;

/**
Handles operations that are independent of version specifics
Really need this to be the VersionManager(facet manager)
Agnostic to implementation details, just adding new versions
Should be responsible for router storage lookup and handling uploads
 */
contract RegistryManager{
    function uploadVersion(uint256 version) external {
        //let RegistryDiamond manage
        
    }
}