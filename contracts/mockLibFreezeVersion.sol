pragma solidity ^0.8.9;

import "./libraries/LibFreezableVersion.sol";
import "./libraries/LibFreezable.sol";

contract DummyFreezableContract {

    bytes32 public currentState;
    

    function initialize(
        FreezableVersion.FreezableParams calldata _freezableState,
        bytes32 initialState

    ) external {
        LibFreezable.FreezableStorage storage fs = LibFreezable
            .freezableStorage();
        FreezableVersion.encodeParameters(_freezableState, fs.currentStateSignatures);
        //set current state, some value less than 5 bits for this example
        //must be checked by versionContract
        currentState = initialState;
    }

    // Example function to update the state
    function updateState(
        FreezableVersion.FreezableParams calldata _freezableParams,
        bytes32 newState
    ) public {
        // Update the state
        LibFreezable.FreezableStorage storage fs = LibFreezable
            .freezableStorage();

        // Call equalityComparison
        FreezableVersion.equalityComparision(
            _freezableParams,
            currentState,
            newState
        );
    }

    // Functions to set currentState and newState for testing purposes
    function setcurrentState(bytes32 _currentState) public {
        currentState = _currentState;
    }

  

    // Getter for testing
    function getFreezableState()
        public
        view
        returns (bytes32 )
    {

        return currentState;
    }
     // Getter for testing
    function getFreezableParams()
        public
        view
        returns (bytes32 )
    {

        return currentState;
    }
}
