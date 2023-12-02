// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/******************************************************************************\
* Author: Nick Mudge <nick@perfectabstractions.com> (https://twitter.com/mudgen)
* EIP-2535 Diamonds: https://eips.ethereum.org/EIPS/eip-2535
*
* Implementation of a diamond.
/******************************************************************************/

import {LibDiamond} from "./libraries/LibDiamond.sol";
import {IDiamondCut} from "./interfaces/IDiamondCut.sol";
import {LibRegistryDiamond} from "./libraries/LibRegistryDiamond.sol";

import "hardhat/console.sol";

contract Diamond {
    constructor(address _diamondCutFacet) payable {
        // Add the diamondCut external function from the diamondCutFacet
        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = IDiamondCut.diamondCut.selector;
        cut[0] = IDiamondCut.FacetCut({
            facetAddress: _diamondCutFacet,
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: functionSelectors
        });
        LibDiamond.diamondCut(cut, address(0), "");
    }
    function addressRoute() private returns (address route_){
        LibRegistryDiamond.RegistryDiamondStorage storage rs = LibRegistryDiamond.registryDiamondStorage();
        uint256 version;
        if( rs.inclusionSet[msg.sig] ){
            assembly{
                version := calldataload(4)
            }
            route_ = rs.version[version].versionAddress; //address zero check in fallback
        }
        else{
            //facet logic
            LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
            route_ = ds.selectorToFacetAndPosition[msg.sig].facetAddress;
        }
        require(route_ != address(0), "Diamond: Function does not exist");
        

    }
    // Find facet for function that is called and execute the
    // function if a facet is found and return any value.
    fallback() external payable {
        address route;
        LibDiamond.DiamondStorage storage ds;
        bytes32 position = LibDiamond.DIAMOND_STORAGE_POSITION;
        // get diamond storage
        assembly {
            ds.slot := position
        }
        // get facet from function selector
        route = addressRoute();
        // Execute external function from facet using delegatecall and return any value.
        assembly {
            // copy function selector and any arguments
            calldatacopy(0, 0, calldatasize())
            // execute function call using the facet
            let result := delegatecall(gas(), route, 0, calldatasize(), 0, 0)
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

//Do we remap selectors, or create a different key for selectors (i.e
// function(version + selector) -> newKey? )
/**
    We should be able to do the second option, as that is abstracted from the user.
    The user simply interfaces with it as normal, and lets the version parameter. 
    So when a user cuts a new facet, they need to ignore the warning of selector 
    collisions though, which might be problematic for other diamond implementations. 
    But this is a tradeoff

    
 */