pragma solidity ^0.8.9;

import "./LibFreezable.sol";
import "./FreezableStructs.sol";
contract FreezableManage is FreezableStructs {
    /**
    @New - Creates a new state space
     */
    event FreezableTransformed(bytes32 newState, bytes32 deltaState);
   

    /**
     *
     * @param _freezableConfig
     * @param _freezeFacetCut
     * @param init
     * @param _initializationData
     */
    function freezableManage(
        FreezableConfig memory _freezableConfig,
        FreezeFacetCut memory _freezeFacetCut,
        address init,
        bytes _initializationData
    ) external {
        LibFreezable.FreezableStorage storage fs = LibFreezable
            .freezableStorage();
        
        /**
            TRANSFORM - 
                Contracts fixed order, represent particular facets, slots determine type. 
            Call freezableVersion - 
            
            call(freezablVersion) - calls parameter verification with the struct, verifies parameters.
            must include changeVector, current state (storage), previous params(storage), new state

            Everything is done in freezableVersion

            1. We send over to main. 
            2. Struct only contains relevant parameters that are being frozen or are frozen and dependent on a changing contract. 
            3. Verify the frozen non-changing parameters don't change, and the frozen changing parameters do change. 
            3a. We create a for loop to call a verification method.

            We don't need storage of frozen paramters if they're frozen into facets already, we 
            Only verificaiton done is:
            1. Find contract dependencies from changing vector.
            2. Call this contract with the calldata for verification, must return success, bubble up error. 
            3. Once all the contracts are verified, cut all of the facets. 
         */
        if (_freezableConfig.action == FreezableAction.Transform) {
            (address _freezableManageAddress,bytes4 freezableVerifySelector) = fs.freezableManageAddress;
            (bool success, bytes memory data) = _freezableManageAddress.call(
                abi.encodeWithSelector(
                    freezableVerifySelector,
                    _freezableConfig.freezableTransform,
                    _freezeFacetCut
                )
            );
        }
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
