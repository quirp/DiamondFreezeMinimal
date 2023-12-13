pragma solidity ^0.8.9;

//owner
import "../interfaces/IDiamondManage.sol";

library LibFreezable {
    bytes32 constant FREEZABLE_STORAGE_POSITION =
        keccak256("freezable.diamond.storage");
    struct FreezableStorage {
        address owner;
        bytes32[] currentStateSignatures;
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

    function freezableTransform(IDiamondManage.Freezable memory _freezable) internal {
        if( IDiamondManage.FreezableAction.New == _freezable.action ){
            // link new address 
            // add/replace new state vector with verified values at that address
            // 
        }
    }
}