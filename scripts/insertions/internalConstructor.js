const parser = require('@solidity-parser/parser')
const fs = require('fs')

function internalConstructorParse(contract){
    //get internal contract name
    //get internal function node
    
//input file 
    let firstFunctionVisited = false

    try {
    const ast = parser.parse(contract,{loc:true})
    console.log(ast)
    } catch (e) {
    if (e instanceof parser.ParserError) {
        console.error(e.errors)
    }
    }
   // Function to process each node
const processNode = (node) => {
    if (node.type === 'FunctionDefinition' && !firstFunctionVisited) {
        if (node.loc) {
            // Check if this line needs adjustment
            if (lines[node.loc.end.line - 1] && lines[node.loc.end.line - 1].trim().endsWith('}')) {
                linesToAdjust.add(node.loc.end.line - 1);
            }
        }
    }
  };
  
  parser.visit(ast, {
    FunctionDefinition: processNode,
    // Add other relevant node types as needed
  });

}


const inputFilePath = "/home/joe/Documents/FreezeVariables/contracts/internals/iParameter2.sol"
// Reading the file, enforcing isolation, and then writing it back
fs.readFile(inputFilePath, 'utf8', function(err, contract) {
    if (err) {
        return console.log(err);
    }
    const updatedSourceCode = internalConstructorParse(contract);
    if (updatedSourceCode) {
        fs.writeFile(inputFilePath, updatedSourceCode, 'utf8', function (err) {
            if (err) return console.log(err);
            console.log('The file has been updated for function isolation.');
        });
    }
});

