pragma solidity ^0.8.9;

contract FreezableRegistry{
    
    mapping(uint256 => Version) version;
    mapping(address => Ecosystem[]) userEcosystems;

    struct Version{
        address versionPointer;
        bool isActive;
    }
    struct Ecosystem{
        bytes stateVector;
        address ecosystemAddress;
        uint256 versionId;
        Facet[] facets;
    }

    struct Facet{
        bytes4[] selectors; //although only setters come and go
        address facetAddress;
    }
    struct FacetDeploy{
        bytes byteCode;
        bytes nonStateParams;
    }
    //Try to dump all actions into the external contract. 
    //Should either be pulling or pushing all the "dyanimc types", not both
    function deployVersion(uint256 _id, address _versionPointer, bool isActive) public {
        //require null Version
        //require onlyowner
        //require 
        //register address pointer
        //deploy non-frozen to verify ALL hashes in version pointer
        // ( deploy via this or link here)
        // instantiate version and store
    }

    //should just deploy new ecosystem 
    function newEcosystem(uint256 _id) external {
        //check active ecosystem and non-null
        //retrieve version pointer
        //call deploy 
    }
    function changeStateVector(bytes32[] calldata stateVector, FacetDeploy[] calldata facets)
    
    function freezableInit() external {
        //should set merkle root for configurations
        //should set initial state
    }
    function upgradeFreezable() external {

    }
    function getFreezables() external view {
        // Needs to access the function selectors from storage. 
        // Need to decide on type of contract at this point
        // Static vs Diamond 
        // Static implies a static registry, which might not be ideal
        // Static registry implies static typing 
        // Dynamic typing enabled through diamonds 
        // Dynamic 
       
    }

}