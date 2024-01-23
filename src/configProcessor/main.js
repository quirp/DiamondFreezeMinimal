/**
 * Need to process the config file 
 * Also need a way to track previous state
 *      -Transformation : We store the previous state, we check the contracts
 *              for consistency with that state, transform the state and store new
 *              state 
 *      -New : Disregard previous state (for now), generate new state space and 
 *              transform it. 
 * 
 *  Assert well formed file. 
 *  Must be 
 * User must create a config file that matches the 
 */
const fs = require("fs")
const {baseConfigAssertions} = require("./configAssertion")
const {ContractGeneratorManager} = require("../ContractGeneratorManager")
function mainConfig(freezeableConfig, transition){
    baseConfigAssertions(freezeableConfig)
    /**
     * Assert properties of config.js isn't malformed with respect to fields, types, structure
     */
    freezeablePropertyAssertion(freezeables)
    //return inserts that will be pluggged in later. 
    
    return 

    //assert state consistency with previous config file 
    //
    
}
/**
 * We're going to have a current and a new config file for the state transition. 
 * Current config assertions:
 *      FacetName
 *            "FacetName":"",
                    "InternalContractInitializor":"",
                    "freezeableInternalGetter" : {
                        "getterSignature":"",
                        "nonfrozenSignature":"",
 */