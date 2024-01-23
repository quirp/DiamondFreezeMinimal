/**
 * Merge facet that contains freezeable and obtain it's AST. 
 * Store in it's binded facet AST storage. 
 */
const fs = require('fs');

const { merge } = require('sol-merger');
const parser = require('@solidity-parser/parser');
const hre = require("hardhat");


async function ASTOut(contractName ){
    //merge dependencies 
    const mergedContract = await mergeContract(contractName)
    //output ast 
    return parser.parse(mergedContract , { loc: true });
    
}

async function mergeContract(contractName) {
    //retrieve contractName path
    const artifact = await hre.artifacts.readArtifact(contractName)
    const sourceName = artifact.sourceName;
    // Get the merged code as a string
    fs.writeFileSync("./A.sol", await merge(sourceName));
    return await merge(sourceName);
}

module.exports = {ASTOut}


if (require.main === module) {
    mergeContract("DummyFreezableContract")
      .then((a) =>{console.log(a); process.exit(0)})
      .catch(error => {
        console.error(error)
        process.exit(1)
      })
  }
  /**
   * Add error handling as we go along
   */