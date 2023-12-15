pragma solidity ^0.8.9;

contract LibFreezableVersionNew {
    struct FreezeableParams {
        bool a;
        bool b;
        address userAddress;
        uint128 lowerAmount;
        uint128 upperAmount;
    }

    uint8 constant freezableStateSize = 20;
function verify(
        Freezable memory _freezable
        FreezeableParams memory _freezableParams,
        bytes32 deltaState,
        bytes32 newState
    ) internal view {
        LibFreezable.FreezableStorage storage fs = LibFreezable
            .freezableStorage();
        bytes16[] storage currentStateSignatures = fs.currentStateSignatures;

        bytes32 changedFrozenState = (deltaState ^ newState); //must be the dependent state, not including changed parametrs
        //bytes32 dependentState = getDependentStateVectors(changedState);
        bytes32 dependentContracts = getDependentFacets(changedFrozenState);
        //getDependent contracts
        bytes32[5] memory _contractDependencies = getContractStateDependencies();
        for(uint256 contractIndex; contractIndex < _contractDependencies.length; contractIndex++){
            if( _contractDependencies[ i ] & changedFrozenState){
                _freezableManage
            }
        }
        //loop over dependent contracts and verify
        //How are we representing contracts? slot position or some sort of tuple?
        //slot position isn't efficient, easy though
        //Other representation, 

    }
    function getContractStateDependencies()
        internal
        pure
        returns (bytes32[5] memory)
    {
        return [
            bytes32(
                0x2400000000000000000000000000000000000000000000000000000000000000
            ),
            0x2300000000000000000000000000000000000000000000000000000000000000,
            0x1200000000000000000000000000000000000000000000000000000000000000,
            0x4900000000000000000000000000000000000000000000000000000000000000,
            0x2200000000000000000000000000000000000000000000000000000000000000
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
