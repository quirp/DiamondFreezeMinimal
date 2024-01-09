/**
 * Main entrypoint for generating a verification.sol contract.
 */

function main(){
    /**
     * Load in config 
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
}