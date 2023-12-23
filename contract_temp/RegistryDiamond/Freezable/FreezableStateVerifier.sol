pragma solidity ^0.8.9;

import "./FreezableStructs.sol";

contract FreezableStateVerifier is FreezableStructs {
    // only need uint16 for any amounts of "hardcoded items" within a contract
    error InvalidFreezableFacetIndex(bytes2);
    error VerificationFailed(address, bytes2, bytes);
    error InvalidContractVerification(address, bytes2, bytes);
    error InvalidFreezableCut(bytes32);
    
    uint16 constant AMOUNT_FREEZABLE_CONTRACTS = 5;
    struct FacetFreezableDependencies {
        string facetName;
        bytes4 verifySelector;
        bytes32 dependencies;
    }

    uint8 constant freezableStateSize = 20;

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
    function contractDependency(
        uint16 variableIndex
    ) internal returns (bytes32) {
        // binary tree which retrieves the appropriate contracts
    }

    function getDependentContracts(
        bytes32 _deltaState
    ) internal pure returns (bytes32 dependentContracts_) {
        for (
            uint16 freezableVariableIndex;
            freezableVariableIndex < AMOUNT_FREEZABLE_VARIABLES;
            freezableVariableIndex++
        ) {
            dependentContracts_ |= contractDependencies(freezableVariableIndex);
        }
    }

    function verify(
        bytes32 _changedFrozenState,
        FreezableFacetCut[] memory _freezeableFacetCut
    ) external {
        bytes32 _verifiedContracts = bytes32(0);
        for (uint256 _cutIndex; _cutIndex < _freezeableFacetCut; _cutIndex++) {
            address _freezableFacetAddress = _freezeableFacetCut[_cutIndex]
                .facetAddress;
            bytes2 _freezableFacetId = _freezableFacetCut[_cutIndex]
                .freezeFacetVerify
                .freezableFacetId;
            bytes memory _verifyCalldata = _freezableFacetCut[_cutIndex]
                .freezeFacetVerify
                .verifyCalldata;
            if( _freezableFacetId == 0){
                if(verifyCalldata.length != 0 ){
                    revert InvalidContractVerification(_freezableFacetAddress,_freezableFacetId,_verifyCalldata);
                }
                continue;
            }
            if (
                _freezableFacetId == 0 ||
                _freezableFacetId > AMOUNT_FREEZABLE_CONTRACTS
            ) {
                revert InvalidFreezableFacetIndex(_freezableFacetId);
            }

            (bytes4 _verifySelector, ) = contractDependency(
                _freezableFacetId
            );


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
        bytes32 _contractDependencies = getDependentContracts(_changedFrozenState);
        if( _verifiedContracts != _contractDependencies){
            bytes32 stateDifference = _verifiedContracts ^ _contractDependencies;
            revert InvalidFreezableCut(stateDifference);
        }
        emit FreezableFacetsVerified();
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
 */
