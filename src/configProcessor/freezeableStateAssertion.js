/**
 * Asserting the state of the current configuration is set. 
 * 
 */
const {ASTOut}  = require('../AST/out/astOut.js');
const {hre} = require('hardhat')
function AssertConfigFile(freezeables) {
    for (let freezeable of freezeables) {
        for (const { FacetName, InternalContractInitializorName, FreezeableInternalGetter }
            of freezeables.contractContainers) {
                let ast;
                //retrieve AST and cache 
                if(this.AST[FacetName] === undefined){
                    this.AST[FacetName] = ASTOut(FacetName)
                }
                ast = this.AST[FacetName] 
                isParentContract(InternalContractIntializorName)
                //assert FreezeableInitialzorContactName is a subContract 
                //assert if frozen that the freezeable name is initialized (need
                //to handle how primitives vs fixed arrays/structs are initialized)
                //assert freezeable 
        }
    }
}
