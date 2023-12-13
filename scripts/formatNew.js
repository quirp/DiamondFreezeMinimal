const prettier = require('prettier/standalone');
const solidityPlugin = require('prettier-plugin-solidity/standalone');

async function format(code) {
  return await prettier.format(code, {
    parser: "solidity-parse",
    plugins: [solidityPlugin],
  });
}

const originalCode = 'contract Foo { uint256 a = 0;function rep()external {}}';
async function main(){
    const formattedCode = await format(originalCode);
    console.log(formattedCode)

}


console.log(originalCode)

main()