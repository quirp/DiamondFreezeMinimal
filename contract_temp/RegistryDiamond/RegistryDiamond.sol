// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/******************************************************************************\
* Author: Nick Mudge <nick@perfectabstractions.com> (https://twitter.com/mudgen)
* EIP-2535 Diamonds: https://eips.ethereum.org/EIPS/eip-2535
*
* Implementation of a diamond.
/******************************************************************************/

import {LibDiamond} from "./libraries/LibDiamond.sol";
import {IDiamondManage} from "./interfaces/IDiamondManage.sol";
import {LibRegistryDiamond} from "./libraries/LibRegistryDiamond.sol";

import "hardhat/console.sol";

contract Diamond {
    constructor(address _diamondManageFacet, bytes32 _freezableState, address _newFreezableAddress) payable {
        // Add the diamondCut external function from the diamondCutFacet
        IDiamondManage.FacetCut[] memory cut = new IDiamondManage.FacetCut[](1);
        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = IDiamondManage(address(0)).diamondManage.selector;
        cut[0] = IDiamondManage.FacetCut({
            facetAddress: _diamondManageFacet,
            action: IDiamondManage.FacetCutAction.Add,
            functionSelectors: functionSelectors
        });
        LibDiamond.diamondCut(cut, address(0), "");
        
        // Insert new freezable state 
        IDiamondManage.Freezable memory freezable = IDiamondManageFreezable( IDiamondManage.FreezableAction.New,
                                                                            _freezableState,
                                                                            _newFreezableAddress);

        
    }
   
    // Find facet for function that is called and execute the
    // function if a facet is found and return any value.
    fallback() external payable {
        address facet;
        LibDiamond.DiamondStorage storage ds;
        bytes32 position = LibDiamond.DIAMOND_STORAGE_POSITION;
        // get diamond storage
        assembly {
            ds.slot := position
        }
        // get facet from function selector
        facet = ds.selectorToFacetAndPosition[msg.sig].facetAddress;
        require(facet != address(0), "Diamond: Function does not exist");
        
        // Execute external function from facet using delegatecall and return any value.
        assembly {
            // copy function selector and any arguments
            calldatacopy(0, 0, calldatasize())
            // execute function call using the facet
            let result := delegatecall(gas(), facet, 0, calldatasize(), 0, 0)
            // get any return value
            returndatacopy(0, 0, returndatasize())
            // return any return value or error back to the caller
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    receive() external payable {}
}

