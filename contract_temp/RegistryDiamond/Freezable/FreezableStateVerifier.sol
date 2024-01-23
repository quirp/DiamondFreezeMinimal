pragma solidity ^0.8.9;

import "./FreezableStructs.sol";
import "./LibDiamond.sol";
/**
 *
 * @title Freezeable State Verifier
 * @author Joe Cocchi
 * @notice FreezableStateVerifier is responsible for maintaining a consistent freezeable 
 *         state across facet cuts. In this implementation of freezeable management, 
 *         we require:
 *              1. Any facet cuts that contain a freezeable variable must be 
 *         **verified** 
 *              2. 
 * 
 *         Verifying consists of ABI encoding your *frozen* freezeables of a given facet. 
 *         There is a natural ordering of freezeable variables from the configuration 
 *         file and we choose to order lowest index to highest. This abi encoded data is 
 *         then sent to a dedicated verifier function on that facet, which should assert
 *         equivalence. 
 * 
 *         Note: Although the verifier is external and has implicit type casting on the 
 *         incoming calldata, the automatically generated verifier will instead take a 
 *         bytes type, then the keccack256 of this value will be compared to the frozen 
 *         signature (bytes32) for equivalence. 
 *          
 *         This verificaton method in the facet can be overidden by the user, 
 *         but is implemented for ease of handling general type comparisions. 
 *         (Deciding when comparing arbitrary array's/struct's values one by one 
 *         is less optimal than a keccak256 comparison isn't obvious to me at
 *         the time of writing ).
 *           
 */
contract FreezableStateVerifier is FreezableStructs {
    // only need uint16 for any amounts of "hardcoded items" within a contract
    error InvalidFreezableFacetIndex(bytes2);
    error VerificationFailed(address, bytes2, bytes);
    error NonFreezeableVerification(address, bytes2, bytes);
    error InvalidFreezableCut(bytes32);
    error InvalidVerifierArrayLengths(uint16, uint16);

    event FreezableFacetsVerified(bytes32, FreezeableVerify[]);

    uint16 constant NULL_FACET_DEPENDENCY_INDEX = type(uint16).max();
    uint16 constant AMOUNT_FREEZEABLE_FACETS = 5;
    uint8 constant AMOUNT_FREEZEABLE_VARIABLES = 20;

   

    function getContractStateDependencies()
        internal
        pure
        returns (bytes4, bytes32)
    {
        // (VerificationSelector,FreezableContractDependency)
        return [
            (
                0x39428493,
                0x2400000000000000000000000000000000000000000000000000000000000000
            )(
                0x39428493,
                0x2300000000000000000000000000000000000000000000000000000000000000
            ),
            (
                0x39428493,
                0x1200000000000000000000000000000000000000000000000000000000000000
            ),
            (
                0x39428493,
                0x4900000000000000000000000000000000000000000000000000000000000000
            ),
            (
                0x39428493,
                0x0300000000000000000000000000000000000000000000000000000000000000
            )
        ];
    }

    /**
     * getDependent contracts will generate the conractDependency vector that the
     * FreezableFacet verification is required to equal at the end of the loop.
     */
    function freezableVariableIndicies()
        internal
        pure
        returns (uint8[] memory indicies_)
    {}
    //retrieves facets the changing freezeables depend on
    function getFreezeableDependencies(
        uint8[] memory _deltaState
    ) internal pure returns (bytes32 dependentContracts_) {
        for(uint16 _freezeableIndex; _freezeableIndex <  )
        // Shift up bits until max freezable variables reached
        //union all contracts that are dependent and return
    }

    function freezeableDependencies(uint8 freezeableIndex) internal pure 
                                    returns( bytes32 freezeableDependency_){
        //binary tree
    }
    function facetDependencies(
        uint8 contractIndex
    ) internal returns (bytes2, bytes32) {
        assembly {
            switch variableIndex
            case 0 {
                return(
                    0x39428493,
                    0x2400000000000000000000000000000000000000000000000000000000000000
                )
            }
        }
    }

    function getFacetDependencies(
        bytes32 _changedFrozenState
    ) internal pure returns (bytes32 dependentContracts_) {
        for (
            uint16 freezableVariableIndex;
            freezableVariableIndex < AMOUNT_FREEZEABLE_VARIABLES;
            freezableVariableIndex++
        ) {
            dependentContracts_ |= contractDependencies(freezableVariableIndex);
        }
    }

    /**
     * @dev We perform two main operations here,
     *      1. Verify facets that are being cut and are dependent on freezeables.
     *      2. Assert all freezable facets that depend on the deltaState
     * @param _changedFrozenState 
     * @param _freezeableFacetCut 
     * @param _verifyParams 
     */
    function verify(
        bytes32 _deltaState,
        LibDiamond.FacetCut[] memory _freezeableFacetCut,
        FreezeableVerify[] memory _verifyParams
    ) external {
        bytes32 _verifiedContracts = bytes32(0);
        if (_verifyParams.length != _freezeableFacetCut.length) {
            revert InvalidVerifierArrayLengths(
                _freezeableFacetCut.length,
                _verifyParams.length
            );
        }
        for (uint256 _cutIndex; _cutIndex < _freezeableFacetCut; _cutIndex++) {
            address _freezableFacetAddress = _freezeableFacetCut[_cutIndex]
                .facetAddress;
            uint16 _freezableFacetId = _verifyParams[_cutIndex]
                .freezableFacetId;
            bytes memory _verifyCalldata = _verifyParams[_cutIndex]
                .verifyCalldata;
            //if not a freezable dependent facet, must have empty verify data
            if (
                // set non freezable facets at max uint16 instead of min,
                // non-trivial selector of the 0th facet verifier should
                // help avoid bugs
                _freezableFacetId == type(uint16).max
            ) {
                if (_verifyCalldata.length != 0) {
                    revert NonFreezeableVerification(
                        _freezableFacetAddress,
                        _freezableFacetId,
                        _verifyCalldata
                    );
                } else {
                    continue;
                }
            }
            //facet ids are type uint16 and sequentially ordered starting from zero.
            if (_freezableFacetId > AMOUNT_FREEZEABLE_FACETS - 1) {
                revert InvalidFreezableFacetIndex(_freezableFacetId);
            }
            //output of contractDependency must be well defined at this point
            (bytes4 _verifySelector, ) = facetDependencies(_freezableFacetId);

            bytes memory _calldata = abi.encodeWithSelector(
                _verifySelector,
                _verifyCalldata
            );

            (bool _success, ) = _freezableFacetAddress.call(_calldata);
            if (!_success) {
                revert VerificationFailed(
                    _freezableFacetAddress,
                    _verifySelector
                );
            }
            //update our verified contract dependencies
            _verifiedContracts |= bytes32(1 << _freezableFacetId);
        }
        bytes32 _contractDependencies = getDependentContracts(
            _deltaState
        );
        if (_verifiedContracts != _contractDependencies) {
            bytes32 stateDifference = _verifiedContracts ^
                _contractDependencies;
            revert InvalidFreezableCut(stateDifference);
        }
        emit FreezableFacetsVerified(_deltaState,_verifyParams);
        //loop for freezefacetCuts
        //verify and update corresponding freezable contract in bytes32
        //require dependentContracts is equal to this final bytes32 updated value
    }
}
/**
 * want to loop over all max freezable avraibles
 */
/**
 * How do we efficiently verify facets and check only he appropriate freezable facets
 * are being cut. So if cutting a freezable and not changing address, don't need checks.
 * This means we must still seperate storage.
 * Freezables can only be replaced under a Transform action
 * New can perform any of the actions
 * Let FreezeVersionable contract check diamond cut
 *
 * SO Selectors can be added as well. This is necessary for cheap transitions.
 * Selectors shouldnt be apart of freeezables. But setters and getters of freezables
 * certainly have an argument.
 *
 * Let the user decide on including setters or getters, competely optional in this
 * version since all we require is a verification function.
 * User picks verifier name (enable automated conventon like verifyVarialbe name)
 * This is set inside Freezable version contract
 *
 * We need changed state to give the contracts that must be verified.
 * We then must not allow any other freezables to change an address in cut (only selectors)
 * Non-freezables allowed to change however.
 *
 *
 * So we have freezable dependent contracts and freezable state variables.
 * When we enter verify we:
 * 1. Look at delta state and retrieve the freezable dependent contracts with
 * respect to this delta
 * 2. Iterate through FrozenCut and verify each freezable, update a bytes32 variable
 *  to assert all freezableCuts that are dependent on the change have been cut and
 *  verified.
 *
 *
 * So we know 0 is non-freezable, know max amount of contracts.
 * How do we create a bytes32 changed contract variable?
 * Need to generate that from the delta state.
 *
 * What if we verify the current contracts in the loop, is there a way to simeltenaiously
 * verify this matches the state change requirements?
 *
 * We have two functions, ContractDependenciesOnFreezables (CD) and
 *  FreezableDependenciesOnContracts (FD).
 * CD takes the contract identifier as input and outputs bytes32 of variable dependencies
 * FD takes in a bytes32
 *
 *
 * Seems like we could create two mappings, which trades off space for time.
 * One which converts a variable in dependent contracts
 * The other converts contract to dependent variables
 *
 * We would get the delta vector
 * Traverse an set of conditional statements.
 * shifting right 1 bit each time.
 * In the meantime we are updating a bytes32 of conractDependencies
 * vs looping over each variable slot
 *
 *
 * The case for getting rid of byte32 representation and switching to uint8
 * We can send an array of uint8 to represent state and delta state
 *
 * What do we want to be performed on chain with respect to guiding a state
 * transformation?
 *
 * Delta state & New state
 * Verify Dependent Contracts
 * 
 * 
 * - Need to retrieve all of the facets that depend on changing freezeables. 
 * - Need to retrieve all of the selectors from each dependent contract
 *  (Note the verification processes already handles proper parameter configuration)
 * 
 * One potential issue with the status quo is it bypasses explicit checking of 
 * freezeables, as we basically take in bytes and tunnel them straight to the 
 * facet's verification method. 
 * 
 * Only way to bypass this would be to maintain an explicit parameter values corresponding
 * to the current freezeables in storage (or part of their keccak256), and then comparing 
 * them. Seems a bit more efficient to just call the facet at bay and let the developer
 * handle this. After all it can be automatically generated for them. 
 * 
 * 
 * 
 * 
 */
