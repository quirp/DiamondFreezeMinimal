const fs = require('fs');
const path = require('path');
const parser = require('@solidity-parser/parser');
const { merge } = require('sol-merger');
const prettier = require('prettier/standalone');
const solidityPlugin = require('prettier-plugin-solidity/standalone');

async function parseSolidityFile(filePath) {
    try {
        // Merge Solidity file contents including imports
        const mergedCode = await merge(filePath,{loc:true});
        // Format the merged code using Prettier with the Solidity plugin
        const formattedCode = await prettier.format(mergedCode, {
            parser: 'solidity-parse',
            plugins: [solidityPlugin],
        });

        // Parse the formatted code to get the AST with location information
        const ast = parser.parse(formattedCode, { loc: true });

        return ast;
    } catch (error) {
        console.error('Error parsing Solidity file:', error);
        throw error;
    }
}

// Example usage
const filePath = './contract_temp/App/content/facets/Parameter2.sol';
parseSolidityFile(filePath).then(ast => {
    console.log('AST:', JSON.stringify(ast, null, 2));
}).catch(error => {
    console.error('Failed to parse Solidity file:', error);
});
