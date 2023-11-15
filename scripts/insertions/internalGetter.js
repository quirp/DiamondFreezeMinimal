const parser = require('@solidity-parser/parser')
const fs = require('fs')

function internalGetterParse(contract) {
    //get internal contract name
    //get internal function node

    //input file 
    let firstFunctionVisited = false
    let returnLine;
    let ast;
    try {
         ast = parser.parse(contract, { loc: true })
        console.log(ast)
    } catch (e) {
        if (e instanceof parser.ParserError) {
            console.error(e.errors)
        }
    }
    // Function to process each node
    const processNode = (node) => {
        if (node.type === 'FunctionDefinition' && !node.isConstructor && !firstFunctionVisited) {
            if(node.body  ){
                let body  = node.body
                if(body.statements){
                    let statements = body.statements
                    if(statements){
                        if(statements[0].type == "ReturnStatement"){
                            returnLine =  statements[0].loc.start.line;
                            firstFunctionVisited = true;
                            return
                        }
                        {
                            throw Error("Function body should consist soley of a single return statement. ")
                        }
                    }
                }
                throw Error("Body should not be empty.")

            }
           
        }

    };

    parser.visit(ast, {
        FunctionDefinition: processNode,
        // Add other relevant node types as needed
    });
    return returnLine
}


const inputFilePath = "/home/joe/Documents/FreezeVariables/contracts/internals/iParameter2.sol"
// Reading the file, enforcing isolation, and then writing it back
fs.readFile(inputFilePath, 'utf8', function (err, contract) {
    if (err) {
        return console.log(err);
    }
    const updatedSourceCode = internalGetterParse(contract);
    if (updatedSourceCode) {
        fs.writeFile(inputFilePath, updatedSourceCode, 'utf8', function (err) {
            if (err) return console.log(err);
            console.log('The file has been updated for function isolation.');
        });
    }
});

