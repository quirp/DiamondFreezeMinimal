pragma solidity ^0.8.9;


//owner 
library LibRegistryDiamond {
    bytes32 constant REGISTRY_DIAMOND_STORAGE_POSITION = keccak256("registry.diamond.storage");

    struct RegistryDiamondStorage{
        bytes4[] deploySelectors;
    }
    function registryDiamondStorage() internal pure returns (RegistryDiamondStorage storage ds) {
        bytes32 position = REGISTRY_DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
    function getDeploySelectors() internal view returns (bytes4[] memory ) {
        return registryDiamondStorage().deploySelectors;
    }
    //remove and pack
    function removeDeploySelectors(bytes4[] memory _selectors) internal {
        //load
    }
    function addDeploySelectors( bytes4 _selector ) internal {
        registryDiamondStorage().deploySelectors.push(_selector);
    }
    /**
        Adds facet address and selectors for the designated new version. 

     */
    function addVersion() internal {
        // versionAddress and struct 
        //struct is names of functions and their corresponding selectors
        //
    }
}


//Need data structure which finds appropriate version given a selector input