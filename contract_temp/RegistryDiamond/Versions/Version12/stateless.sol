pragma solidity ^0.8.0;

contract DependencyChecker {
    // Hardcoded data representing the relationship between contracts and variables.
    // Let's assume we have 3 contracts and each contract has a byte representing its dependency on 8 variables.
    // Each bit in the byte represents the dependency on a corresponding variable.
    bytes3 private constant contractDependencies = 0x3C_CC_F0;//generated from config file


    // Function to check dependencies of all contracts on the variables.
    // Returns an array where each element represents if the corresponding contract depends on any of the variables.
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
            for (uint8 j = 0; j < 8; j++) {
                // Check dependency of each variable
                bytes1 mask = bytes1(uint8(1) << j);
                stateDependencies[i][j] = (contractDependency & mask) != 0 && (variableChanges & mask) != 0;
            }
        }
        return stateDependencies;
    }
}