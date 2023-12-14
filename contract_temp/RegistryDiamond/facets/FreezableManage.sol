pragma solidity ^0.8.9;

contract FreezableManage{
    /**
    @New - Creates a new state space
     */
    enum FacetCutAction {Add, Replace, Remove}
    enum FreezableAction {New,Transform,None,Remove}
    struct FacetFreezeCut{
        address facetAddress;
        bytes4[] facetSelectors;
        bytes verifyData;
        FacetCutAction cutAction;
    }
 
    struct FreezableDeploy{
        FreezableAction action;    
        bool[] paramChange;
    }
    function freezableManage(FreezableDeploy memory _freezableDeploy, DiamondCut[] memory diamondCut, address init, bytes _initializationData) external{
        if (_freezableDeploy.action == FreezeableAction.Transform) _freezableTransform();
        /**
         * 
         */
    }
    function _freezableTransform() internal {
        //
    }
}

/**
What about refreezing?  We can't handle that atm. We'd have to signal a change. 
This all might not be a big issue if there's an sdk that helps with params. 
So no we need an input param vector, state change vector as well. 



Transform Call:
Will need to cut diamonds on a state change no matter what. 
Will need to verify the unchanged (Do we care about the storage varailbe changes?)
It doesn't seem like we should be, just frozens. 
If that's the case we only care about params being frozen in state transition. Would be useful to have an atomic 
transition, especially frozen to unfrozen. But so long as it's unfrozen already, don't need to track changes as 
only verification being done is on the frozens. 

All the incoming information for a given transaction: 
Params that are changing and going to be frozen, which is seperated into a vector of param valaues and boolean vector of changing. 
Also need to perform a cut, if cut through this facet we don't need to check for freezable contract dependency. 
Seems like getting rid of diamondCut is better. Cut things that have no param changes

DiamondCut memory cut
address init
bytes calldata 
Freezable memory _freezable

Freezable{
    bytes freezableVersionCalldata;
    bytes32 paramVector;
    bytes32 isChangeVector;
}

I forgot in this scenario we're not deploying, but merely cutting. So could add verifier in each facet.
Add an external function which retrieves the byte32 of the paramaters abi encoded hash. Now this facet can 
be verified within the diamond. So that can all be done at once, but would need to call each contract's verifier. 



Want developers to have a sense of state. DiamondCuts don't need any verification as there's no intended purpose of the facets,
aside from not being address(0) and no address/selector collisions. For freezables, the purpose is to manage a variables frozen state,
and in turn adding/removing the appropriate facets to accomodate this state. 
So we can only transform a state accompanied with the corresponding facetCuts, param values (for verification), and state change vector. 
When not changing state but are cutting a freezable facet, still need the params (only on address change, not selector change).
When cutting non-freezable facet, check to verify that fact, cut. 


//New 
Trickier than transform as we'll have new state space, have to link the new version, make new call to that version. 
Also since this isn't a deployment implementation, we can verify the entire state on new deploy. 

So we need a function that verifies particular facets and assures








 */