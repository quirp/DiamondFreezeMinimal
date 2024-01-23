/**
 * Creates a simple wrapper around generated functions for testing purposes.
 * @param {function that is to be tested} testFunction 
 * @returns 
 */
function generateSolidityContract(testFunction) {
    const solidityContract = `
        pragma solidity ^0.8.0;

        contract MyWrappedContract {
            // Placeholder for dynamically generated function
            ${testFunction}
        }
    `;

    return solidityContract;
}

module.exports = {generateSolidityContract}