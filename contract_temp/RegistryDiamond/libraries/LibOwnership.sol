pragma solidity ^0.8.9;

//owner

library LibOwnership {
    bytes32 constant OWNERSHIP_STORAGE_POSITION =
        keccak256("ownership.diamond.storage");
    struct OwnershipStorage {
        address owner;
    }

    function ownershipStorage()
        internal
        pure
        returns (OwnershipStorage storage os)
    {
        bytes32 position = OWNERSHIP_STORAGE_POSITION;
        assembly {
            os.slot := position
        }
    }
}