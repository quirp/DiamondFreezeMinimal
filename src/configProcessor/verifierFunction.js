const {config} = require("../freezeableConfig")
/**
 * Requires function params to match this facet's frozen freezeables. 
 */

/**
 * 
 * @param {ordered array of freezeable objects} freezeables 
 */
function verificationGenerator(freezeables){
    //note verification constant is included in the facet
    let verifier = `function ${verifierName}(${freezeableArgs(freezeables)}) external pure {
        bytes memory
    }`;
}
function freezeableArgs(freezeables){
    //we want to extract the freezeable type and name from each array element
    //we then want to join those with a ' ' delimiter
    //we then want to join all of the latter by a comma and space
    const parameterEntries = freezeables.filter((freezeable)=>freezeable.isFrozen).map( (freezeable)=>   [freezeable.type,freezeable.name].join(" ") )
     console.log(parameterEntries.join(', '))
    return parameterEntries.join(', ')
}


if(require.main === module){
    freezeableArgs(config.freezeables);
}
/**
 * Need param type to be generated and inserted here a some point.
 * (i.e. user enters uint8[4] bound as type but will need uint8[4] 
 *  memory bound ... function parameter declarations)
 */