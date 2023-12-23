const fs = require('fs');

function generateBinaryTree(depth) {
    let code = 'pragma solidity ^0.8.9;\n\ncontract BinaryTree {\n\n    struct MyStruct {\n        uint256 value;\n        string name;\n    }\n\n    function getValue(uint16 key) public pure returns (MyStruct memory) {\n';

    function writeIfStatements(currentDepth, path) {
        if (currentDepth === depth) {
            code += `        return MyStruct({value: ${path}, name: "Path ${path}"});\n`;
            return;
        }

        code += `        if (key < ${2 ** (depth - currentDepth - 1)}) {\n`;
        writeIfStatements(currentDepth + 1, path * 2);
        code += '        } else {\n';
        writeIfStatements(currentDepth + 1, path * 2 + 1);
        code += '        }\n';
    }

    writeIfStatements(0, 1);

    code += '    }\n}\n';

    return code;
}

const solidityCode = generateBinaryTree(4); // Adjust depth as needed
fs.writeFileSync('BinaryTree.sol', solidityCode);
console.log('Solidity code written to BinaryTree.sol');
