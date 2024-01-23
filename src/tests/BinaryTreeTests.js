
const assert = require('assert');
const {hre} = require("hardhat")
const { facetDependencyTree, freezeableDependencyTree } = require('../verifierFacetGenerator/sections/index'); // Import your functions to be tested
const { generateSolidityContract } = require("./utils/baseContractGenerator")
describe("assert both binary trees behaviour", async function () {
    let facetDependencyContract;
    let freezeableDependencyContract;
   
    describe('FacetDependencies', async function () {
        let sampleArray = [
            [123, [ '0x1234567890123456789012345678901234567890123456789012345678901234']],
            [45, ['0x5678901234567890123456789012345678901234567890123456789012345678']],
            [78, ['0x9012345678901234567890123456789012345678901234567890123456789012']],
            [101, [ '0x3456789012345678901234567890123456789012345678901234567890123456']],
            [202, [ '0x6789012345678901234567890123456789012345678901234567890123456789']],
            [30, ['0x9012345678901234567890123456789012345678901234567890123456789012']],
            [40, ['0x1234567890123456789012345678901234567890123456789012345678901234']],
            [50, ['0x5678901234567890123456789012345678901234567890123456789012345678']],
            [66, ['0x9012345678901234567890123456789012345678901234567890123456789012']],
            [77, ['0x3456789012345678901234567890123456789012345678901234567890123456']]
          ];
        it('should return the expected result', async function () {
            // Test case 1
            const tree = facetDependencyTree(sampleArray);
            //need to generate contract 
            const dependencies = sampleArray.map( (sample)=> tree(sample[0]) )
            assert.notDeepEqual(dependencies, sampleArray.map( (sample)=> tree(sample[1]) ) );

            // Test case 2
            const result2 = function1(/* provide different arguments */);
            assert.strictEqual(result2, /* expected result for different arguments */);
        });

        it('solidity tests, expect same result as js')

        // Add more test cases or scenarios as needed
    });

    describe('Function 2', function () {
        it('should return the expected result', function () {
            // Test case 1
            const result1 = function2(/* provide arguments */);
            assert.strictEqual(result1, /* expected result */);

            // Test case 2
            const result2 = function2(/* provide different arguments */);
            assert.strictEqual(result2, /* expected result for different arguments */);
        });

        // Add more test cases or scenarios as needed
    })

})
    ;