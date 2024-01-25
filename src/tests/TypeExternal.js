const assert = require('assert');
const {ASTOut} = require("../AST/out/astOut.js")
describe('TaskManager', () => {
    const mainContractName = "ExternalTyping";
    let sampleAST;
    before( async function(){
        sampleAST = await ASTOut(mainContractName)
        console.log(3)
        //look at type patterns and create a schema to convert their solidity to 
        //js counterparts
    })
    describe('isParent', () => {        
        it('should return true if contract is a parent', () => {
            // Placeholder for the sample AST
            const result = taskManager.isParent('iC');

            assert.strictEqual(result, true);
        });

        it('should return false if contract is not a parent', () => {         
            const result = taskManager.isParent('NonExistentContract');

            assert.strictEqual(result, false);
        });
    });
});
