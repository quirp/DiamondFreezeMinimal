/**
 * Main entrypoint for generating a verification.sol contract.
 * New - Transforms to target state without asserting current state. 
 * Transform - Asserts current state then transforms to target state.
 */
const {mainConfig} = require('./configProcessor/main')
function main(){
   /**
    * Assert base config file keys/values
    * Assert freezeable getters keys/values, assert they exist 
    *   - Bind AST if doesn't already exist
    * Assert freezeable types/values
    * Generate code inserts
    *   - Freezeable constant initializaitons
    *   - Freezeable getter return values
    * Grab AST of internal initializor contract, instantiate class
    *   - Grab all dependent freezeables on this contract
    *   -   save output of dependencies
    *   - Counter for new lines removed and added. 
    *   - Add/Remove lines per contract
    *   -Generate verifier
    *   Generate Contract
    *       - Number of dependent Facets
    *       - Number of freezeables
    *       - Facet Dependencies
    *       - Freezeable Dependencies
    *       - 
    */  
    
}


 /**
     * Load in config 
     * Create an edit object for binding
     * Assert well assembled config file
     *      - Assert valid freezeable state 
     *          - Need freezeable state 
     *          - Triple (FreezeableName, ExternalFaceName, InternalContractName) (Assume freezeable A can't exist in more than
     *              one internal conract of a given external contract)
     *              Assert this consistency.
     *          - Assert the internal getter exists for storage
     *          - Assert validator exists
     *          - Assert validator works with current params
     * Determine max facets,freezeables
     */
    /**
     * How do we enable features to be added?
     * Getting rid of variables?
     * Just add it later, for now 
     */