pragma solidity ^0.8.9;

import "../libraries/LibRegistryDiamond.sol";
//Logic for the diamond portion of the RegistryDiamond
contract RegistryDiamondFacet{
    function getDeployFacets() external view returns(bytes4[] memory){
        return LibRegistryDiamond.getDeploySelectors();
    }
    function addDeploySelectors(bytes4 _selector) external {
        LibRegistryDiamond.addDeploySelectors(_selector);
    }
}