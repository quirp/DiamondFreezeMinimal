const parser = require('@solidity-parser/parser')
//input file 

const input = `
    contract test {
        uint256 a;
        function f( uint256 a) external returns(uint) {
            return 4;
        }
    }
`
try {
  const ast = parser.parse(input,{loc:true})
  console.log(ast)
} catch (e) {
  if (e instanceof parser.ParserError) {
    console.error(e.errors)
  }
}

// Function to process each node
const processNode = (node) => {
  if (node.type === 'FunctionDefinition') {
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