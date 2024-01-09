pragma solidity ^0.8.9;

//owner
import "../interfaces/IDiamondManage.sol";

library LibFreezable {
    error FreezableFacetCollision(address, bytes4);
    error FreezableSelectorCollision(address, bytes4);

    bytes32 constant FREEZABLE_STORAGE_POSITION =
        keccak256("freezable.diamond.storage");

    

    struct FreezableStorage   {   
        address verifyAddress;
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

    
}
