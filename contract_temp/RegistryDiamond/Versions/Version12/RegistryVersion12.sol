pragma solidity ^0.8.9;

//IMPORT GENERATED CONTRACT AND INHERIT
contract RegistryVersion12 {

    //TYPES ARE IN GENERTATED CONTRACT
    function deployVersion(
        uint256 version,
        FacetParameters memory facetParameters,
        FreezableParameters memory freezableParameters,
        bool isActive
    ) external {
        //internal route
    }
    function upgradeVersion(
        uint256 version, 
        uint256 previousVersion,
        FacetParameters memory facetParameters,
        FreezableParameters memory freezableParameters
    )
    external{
            //Do this last, need to work this out
    }
    
    function parameterChange( uint256 version,
                                FacetParameters memory facetParameters,
                             FreezableParameters memory freezableParameters
    ) external {

    }

}

/**
THIS IS A GENERATED CONTRACT!
 */