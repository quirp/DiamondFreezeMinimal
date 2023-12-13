pragma solidity ^0.8.9;

//owner
import "../interfaces/IDiamondManage.sol";

library LibFreezable {
    error FreezableFacetCollision(address, bytes4);
    error FreezableSelectorCollision(address, bytes4);

    bytes32 constant FREEZABLE_STORAGE_POSITION =
        keccak256("freezable.diamond.storage");

    struct FacetAddressAndPosition {
        address facetAddress;
        uint96 functionSelectorPosition; // position in facetFunctionSelectors.functionSelectors array
    }

    struct FacetFunctionSelectors {
        bytes4[] functionSelectors;
        uint256 facetAddressPosition; // position of facetAddress in facetAddresses array
    }

    struct FreezableStorage {
        address owner;
        bytes16[] currentStateSignatures;
        // maps function selector to the facet address and
        // the position of the selector in the facetFunctionSelectors.selectors array
        mapping(bytes4 => FacetAddressAndPosition) selectorToFacetAndPosition;
        // maps facet addresses to function selectors
        mapping(address => FacetFunctionSelectors) facetFunctionSelectors;
        // facet addresses
        address[] facetAddresses;
    }

    function freezableStorage()
        internal
        pure
        returns (FreezableStorage storage os)
    {
        bytes32 position = FREEZABLE_STORAGE_POSITION;
        assembly {
            os.slot := position
        }
    }

    function freezableTransform(
        IDiamondManage.Freezable memory _freezable
    ) internal {
        if (IDiamondManage.FreezableAction.New == _freezable.action) {
            // link new address
            // add/replace new state vector with verified values at that address
            //
        }
    }

    function freezableCollisionCheck(
        IDiamondManage.FacetCut[] memory _cut
    ) internal view {
        FreezableStorage storage fs = freezableStorage();
        for (uint256 cutIndex; cutIndex < _cut.length; cutIndex++) {
            address _facetAddress = _cut[cutIndex].facetAddress;
            bytes4[] memory _facetSelectors = _cut[cutIndex].functionSelectors;

            for (
                uint256 selectorIndex;
                selectorIndex < _facetSelectors.length;
                selectorIndex++
            ) {
                bytes4 _cutSelector = _facetSelectors[selectorIndex];
                address freezableAddress = fs
                    .selectorToFacetAndPosition[_cutSelector]
                    .facetAddress;

                if (freezableAddress != address(0)) {
                    revert FreezableSelectorCollision(
                        freezableAddress,
                        _cutSelector
                    );
                }
            }
        }
    }
}
