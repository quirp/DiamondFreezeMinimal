pragma solidity ^0.8.9;

/**
 * @title
 * @author Joe Cocchi
 * @notice
 */
contract FreezableStructs {
    enum FreezableAction {
        New,
        Transform,
        None,
        Remove
    }
    enum DiamondCutAction {
        Add,
        Replace,
        Remove
    }
    /**
    We need to perform two operations using properties from FreezeFacetCut:
    1. Verify the facetAddress has the approprate freezeable parameter values
        via verifyData propety. 
    2. Run through the appropriate diamond cut logic
     */
    struct FreezeableFacetCut {
        address facetAddress;
        DiamondCutAction action;
        bytes4[] facetSelectors;
        FreezeVerify freezeFacetVerify;
    }
    /**
    Need a way to identify which facet we're on.
    1. Positional based- Create a vector and have the slots correspond to facets.
    2. Names - Create names for each facet. 
    Option 2 scaled better and is more understandable.  
     */
    struct FreezeVerify {
        bytes verifyCalldata;
        bytes2 freezableFacetId; //[1,2^16-1] valid facetFreezableIdenifiers,0 for non-case

    }

    /**
    @param action Determines how the freezable state will change
    @param freezableVerifySelector Only used in the creation of new freezable state space
    @param paramChange Flags which params are changing (which is needed if a frozen variable is 
                        refrozen to a different value)
    @param newState Desired freezable state 
     */
    struct FreezableConfig {
        FreezableAction action;
        bytes4 freezableVerifySelector;
        FreezableTransform freezableTransform;
    }
    struct FreezableTransform {
        bytes32 deltaState;
        bytes32 newState;
    }
}
