function freezeablePropertyAssertion(freezeables){
   if (!Array.isArray(freezeables)){
        throw Error("Freezeables property must have an array value.")
   } 
   for(let freezeable of freezeables){
        if( !freezeable.hasAttribute("name") || typeof freezeable.name !== 'string' || freezeable.name === "" ){
            throw Error ("name property must be a non-empty string.")
        }
        if(!freezeable.hasAttribute("type")){
            throw Error ("type propety must be a non-empty string.")
        }
   }
}

function baseConfigAssertion(){
    //check version property
    if(!freezeableConfig.hasAttribute("version")){
        throw Error("freezeableConfig doesn't have attribute 'version' (string)");
    }
    else if(typeof freezeableConfig.version != string){
        throw Error("version must be type string")
    }
    //assert freezeable config sol file exists
    if(!freezeableConfig.hasAttribute("configSolPath")){
        throw Error("freezeableConfig doesn't have attribute 'configSolPath' (string)");
    }
    else if(typeof freezeableConfig.configSolPath != string){
        throw Error("configSolPath must be type string")
    }
    
    if(!freezeableConfig.hasAttribute("freezeables")){
        throw Error("freezeableConfig doesn't have attribute 'freezeables' (string)");
    }
}


exports.defualt = {baseConfigAssertion,freezeablePropertyAssertion}
/**
 * We just want to create the new contracts?
 * Also want to generate the verifier calldata.
 * Also want to store state which means storing values. 
 * generate verifier contract
 * No drastic type checking, basic checks. Let solidity do the heavy lifting. 
 * 
 * Create verifier calldata for this transformation
 * Create FreezeableCut
 * Create Verifier Contract
 * Create Transformed contracts
 * Create Updated config file   
 *  
 * Types
 * =================
 * User must enter type and value of each freezeable. 
 * We then want to place these values and types into a contract at some point
 * Need a converter that takes 
 * 
 * So we create a config file
 */