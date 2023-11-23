pragma solidity ^0.8.0;

contract DependencyChecker {
    // Hardcoded data representing the relationship between contracts and variables.
    // Let's assume we have 3 contracts and each contract has a byte representing its dependency on 8 variables.
    // Each bit in the byte represents the dependency on a corresponding variable.
    
    bytes3 public constant contractDependencies = 0x3C_CC_F0;//generated from config file
    //bytes32[] public constant nonFrozenFacetHashes = [];
    uint8 public constant numFacets = 6;
    uint16 public constant stateVector = 10;
    string[] public constant = ["DiamondCutFacet","OwnershipFacet","Facet1","Facet2"];
    //string[] public constant stateVariableNames = ["String1", "String2", "String3", "String4", "String5"];

    //string[] public constant facetSelectors = ["String1", "String2", "String3", "String4", "String5"];

    function getFunctionSignatures() public pure returns (string[5] memory signatures_) {
        return ["String1", "String2", "String3", "String4", "String5"];
    }

    // function getFacetSelectors() public view returns (bytes4[] memory selectors_){
    //     selectors_ = new bytes4[](numFacets);
    //     for (uint i; i < numFacets; i++){
    //         selectors_[i] = facetSelectors[i];
    //     }
    // }
   //Returns all state variables impacted by state change
    function checkContractsDependencies(bytes1 variableChanges) public pure returns (bytes1 dependentState) {
        for (uint i; i < contractDependencies.length; i++) {
            // Check each contract's dependency based on the variable changes
            dependentState = (contractDependencies[i] & variableChanges) != 0 ? contractDependencies[i] | dependentState : dependentState  ;
        }
    }

    // Function to find state variables that each contract depends on.
    // Returns a 2D array where each element represents the state variables dependency vector for each contract.
    function findStateVariablesDependencies(bytes1 variableChanges) public pure returns (bool[3][8] memory) {
        bool[3][8] memory stateDependencies;
        for (uint i; i < 3; i++) {
            bytes1 contractDependency = contractDependencies[i];
            for (uint8 j ; j < 8; j++) {
                // Check dependency of each variable
                bytes1 mask = bytes1(uint8(1) << j);
                stateDependencies[i][j] = (contractDependency & mask) != 0 && (variableChanges & mask) != 0;
            }
        }
        return stateDependencies;
    }
}

/**
versionContract should contain 
variable & contract dependencies 
variable names 
facetSignatures
non-frozen-hashes */

/**
This returns contract dependencies on states. Each contract returns state vector of dependencies
Do we just need the union of state vectors?
Could have user upgrade via contract and state vector. 
This information would be known via view functions on chain. 
Upload phase, Deploy phase. This would be for security purposes. 
So upload, goes through all the checks. Let user simply check their associated variables, highlight new ones. 
User can then verify off-chain and deploy when ready. 





Hardcoded contract dependencies

state size 
external contracts dependence on state
number of external contracts 
types for state size



What do we want for frontends?
Okay to have redundancy on-chain
User will need to deploy version. 
User should be able to retrieve state vector, version number, contract hashes. 
User's should generate contract with re
Currently, all we can do is input an array of (ContractBytecode,DefaultConstructorArgumetns,FrozenStateVariables)
Default constructor arguments should be on-chain? Upload them each time is a security vulnerability. All constructors are freezables?
But would needed to be treated differently how? It can't be unfrozen.
So state vector consists of all constructor parameters of facets. 
Must all create accessors to these variables and compared when changes occur. 

So user wants to deploy a new state change. 
Frontend communicates the current state vector via view function. This would imply getters
for constructor varaibles would be required, but only those.. big deal? 
What's a better way to handle constructor security? Need to know if user intends to change constructor or not. 
Theorem: In the non-frozen state, the constructor params do not change. Issue is constructor params can depend on current deployment.
Really need more flexible, albiet less elegant solution.. Having an upload state and deploy state seems to help this from a security standpoint.
Can we do it in one go? This would involve storing constructor params...

Maybe we could do (Bytecode,ConstructorParams[],StateVariables[])?
ConstructorParams could be flagged as empty... would need to compare bytes arrays each time as types..
Need to reupload each time and have two seperate stages if desired. 
So have an upload, deploy, and uploadDeploy methods. 
If constructor arguments are permanent, can create a mechanism to store that for new uploads
dynamic constructor parameters would have to be separated. 

Quick thoughts on dynamic typing by referencing. 
Can store addresses to new function with different types
This function 
 */