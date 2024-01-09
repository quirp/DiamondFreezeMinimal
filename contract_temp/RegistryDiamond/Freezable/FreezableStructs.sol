pragma solidity ^0.8.9;

import "./LibDiamond.sol";

/**
 * @title
 * @author Joe Cocchi
 * @notice
 */
contract FreezableStructs {
    enum FreezableAction {
        New,
        Transform
    }
     struct FreezeableCut{
        LibDiamond.FacetCut facetCut;
        FreezeableVerify verify;
    }
    
    /**
    Need a way to identify which facet we're on.
    1. Positional based- Create a vector and have the slots correspond to facets.
    2. Names - Create names for each facet. 
    Option 2 scaled better and is more understandable.  
     */

    struct FreezeableVerify {
        bytes verifyCalldata;
        uint16 freezableFacetId; //[1,2^16-1] valid facetFreezableIdenifiers,0 for non-case

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
        NewStateSpace newStateSpace;
    }
    //Only need new state on a New State Space
    struct FreezableTransform {
        uint8[] deltaState;
        bytes32 newState;
    }
    /**
     * @param contractMapping - Used for mapping 
     */
    struct NewStateSpace{
        address versionAddress;
        //uint8 contractMapping; 
    }
}   
/**
 * How do we manage facets that depend on freezeables generally
 * but don't make any freezeable state changes? Always check 
 * freezables to enforce state consistency?
 * 
 * So assert the following:
 * 1. Each freezable dependent contract is verified
 * 2. Each deltaState dependency contract is verified
 */