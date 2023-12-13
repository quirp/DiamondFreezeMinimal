pragma solidity ^0.8.9;

import "../internals/iParameter3.sol";
import "../libraries/Lib3.sol";
contract Third is iThird{
    function getParameter3() external view returns (uint256){
        _getVariable3();
    }
    function setParameter3(uint256 _parameter3) external {
        Lib3._setParameter3(_parameter3);
    }
}

/**
 * Do we need an entire registry? No, we could forget all the registry nonsense.
    On a facet cut, simply manage the needed maintenace at that point. 
    This consists of uploading a new Version contract with a new facet change. 
    What's the minimal amount of information and security needed to implement freezables?
    Would need an atomic transaction that links to a freezableFacet.
    So diamond cut would then have the ability to cut and deal with freezables. 
    The *deal with freezables* part would consist of potentially:
    1. Doing nothing at all. 
    2. Checking the parameters against the incoming facetCut. 
        To do this we'd need a contract identifier that would map to freezable variables. 
    So selector would be chosen to represent a facet? Otherwise have to add new infastructure on-chain?
    Off-chain we can simply designate facets by name, on-chain we'd need to add more information.
    What is minimal overhead implementation?
    Tag selectors off-chain?
    Need on-chain information regardless.
    What's ultimately tyring to be accomplished? 
    Hard- Transitioning back and forth between a variables location, storage or in bytecode
    Does this even need to be on-chain? Could simply be a tool user's use to deploy off-chain?
    Then we use it in an implementation where we keep track of user's.
    Minimal implemenation:
        What stops from just off-chain tooling and deploy? Should have some notion of state
        on-chain and conflict checks with diamond and freezable state. 
        

 */