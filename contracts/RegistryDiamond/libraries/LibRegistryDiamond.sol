pragma solidity ^0.8.9;


//owner 
library LibRegistryDiamond {
    bytes32 constant REGISTRY_DIAMOND_STORAGE_POSITION = keccak256("registry.diamond.storage");
    event NewVersion(uint256);
    struct Version{
        address versionAddress;
        bool isActive;
    }
    struct RegistryDiamondStorage{
        mapping (bytes4 => bool) inclusionSet;
        mapping( uint256 => Version) version;
        uint256 latestVersion;
        
    }
    function registryDiamondStorage() internal pure returns (RegistryDiamondStorage storage ds) {
        bytes32 position = REGISTRY_DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
    //Deploy Selectors
    //========================
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
    //=========================
    
     /**
        Adds facet address and selectors for the designated new version. 
     */
    function uploadVersion(uint256 version, address versionContract, bytes4[] memory registrySelectors , bool isActive) internal {
        RegistryDiamondStorage storage ds = registryDiamondStorage();
        require(version > ds.latestVersion,"Uploaded version number must be greater than the latest version");

        for(uint256 i; i < registrySelectors.length; i++){
            ds.inclusionSet[registrySelectors[i]] = true;
        }

        ds.version[version] = Version(versionContract, isActive);

        if (isActive){
            ds.latestVersion = version; // else can be changed in activateVersion method
            emit NewVersion(version); 
        }
    }
    //onlyOwner
    function activateVersion(uint256 version) internal {
        
    }
    
}