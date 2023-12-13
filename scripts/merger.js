const { merge } = require('sol-merger');
const fs = require('fs');
async function main() {
    // Get the merged code as a string
    const mergedCode = await merge('./contract_temp/App/content/facets/Parameter2.sol', { removeComments: true });
    // Print it out or write it to a file etc.
    console.log(mergedCode);
    fs.writeFileSync("./DiamondCutFacet.sol", mergedCode)
    return mergedCode
}


main()