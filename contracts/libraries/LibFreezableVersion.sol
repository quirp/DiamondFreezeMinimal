pragma solidity ^0.8.9;

import "./LibFreezable.sol";

/**

 */
library FreezableVersion {
    //hard code depenedencies of state variables and facets
    //create a struct for verification to avoid stack overflow
    // struct keeps types.
    //
    struct FreezableParams {
        address userAddress;
        uint128 lowerAmount;
        uint128 upperAmount;
        bool a;
        bool b;
    }

    uint8 constant freezableStateSize = 20;

    function encodeParameters(
        FreezableParams memory _freezableParams,
        bytes32[] storage _freezableSignatures
    ) internal  {
        
        _freezableSignatures.push( 
        bytes32(bytes16(keccak256(abi.encode(_freezableParams.userAddress)))) |
                       (keccak256(abi.encode(_freezableParams.lowerAmount)) >> 128)
        );

        _freezableSignatures.push( 
        bytes32(bytes16(keccak256(abi.encode(_freezableParams.upperAmount)))) |
                       (keccak256(abi.encode(_freezableParams.a)) >> 128)
        );

        _freezableSignatures.push( 
            bytes32(bytes16(keccak256(abi.encode(_freezableParams.b))))                 
        );

    }
    
    function equalityComparision(
        FreezableParams memory _freezableParams,
        bytes32 currentState,
        bytes32 newState
    ) internal view {
        LibFreezable.FreezableStorage storage fs = LibFreezable
            .freezableStorage();
        //can optimize at this line by not traversing after last dependent varaible
        bytes32[] memory currentStateSignatures = fs.currentStateSignatures; 

        bytes32 changedState = (currentState ^ newState); //must be the dependent state, not including changed parametrs
        bytes32 dependentState = getDependentStateVectors(changedState);
        //bytes16[] and 2 SLOAD's hot storage for second variable cheaper than one SLOAD bytes32[] and splitting
        //into memory (SLOAD's not including)

        //optiimzaiton- values < 16bytes can be stored directly. could add this information into hardcode
        //would need to handle different types.
        if (bytes32(uint256(2 ** 0)) & dependentState == 0) {
            require(
                bytes16(keccak256(abi.encode(_freezableParams.userAddress))) ==
                    bytes16(currentStateSignatures[0]),
                "User inputted dependent state vector component doesn't match the previous state's counterpart - userAddress"
            );
        }
        if (bytes32(uint256(2 ** 1)) & dependentState == 0) {
            require(
                bytes16(keccak256(abi.encode(_freezableParams.lowerAmount))) ==
                    bytes16( currentStateSignatures[0] << 128),
                "User inputted dependent state vector component doesn't match the previous state's counterpart - lowerAmount"
            );
        }
        if (bytes32(uint256(2 ** 2)) & dependentState == 0) {
            require(
                bytes16(keccak256(abi.encode(_freezableParams.upperAmount))) ==
                    bytes16( currentStateSignatures[1]),
                "User inputted dependent state vector component doesn't match the previous state's counterpart - upperAmount"
            );
        }
        if (bytes32(uint256(2 ** 3)) & dependentState == 0) {
            require(
                bytes16(keccak256(abi.encode(_freezableParams.a))) ==
                    bytes16(currentStateSignatures[1] << 128),
                "User inputted dependent state vector component doesn't match the previous state's counterpart - a"
            );
        }
        if (bytes32(uint256(2 ** 4)) & dependentState == 0) {
            require(
                bytes16(keccak256(abi.encode(_freezableParams.b))) ==
                    bytes16(currentStateSignatures[2]),
                "User inputted dependent state vector component doesn't match the previous state's counterpart - b"
            );
        }
    }

    function contractStateDependencies()
        internal
        pure
        returns (bytes32[5] memory)
    {
        return [
            bytes32(
                0x0F00000000000000000000000000000000000000000000000000000000000000
            ),
            0x0D00000000000000000000000000000000000000000000000000000000000000,
            0x0A00000000000000000000000000000000000000000000000000000000000000,
            0x0900000000000000000000000000000000000000000000000000000000000000,
            0x0200000000000000000000000000000000000000000000000000000000000000
        ];
    }

    // Function to get the union of all touched state vectors excluding the input
    function getDependentStateVectors(
        bytes32 inputStateVector
    ) public pure returns (bytes32) {
        bytes32 unionStateVector = 0x00;
        bytes32[5]
            memory _contractStateDependencies = contractStateDependencies();
        for (uint i = 0; i < _contractStateDependencies.length; i++) {
            if (inputStateVector & _contractStateDependencies[i] != 0) {
                // Union with other state vectors
                unionStateVector |= _contractStateDependencies[i];
            }
        }

        // Remove the initial state vector values
        return unionStateVector & ~inputStateVector;
    }
}

/**
User is inserting all dependent and changing parameters. 
These dependent parameters are checked against the hashed bytes16 correspondent. 
They are required to equal each other.
 */
