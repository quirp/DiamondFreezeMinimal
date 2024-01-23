pragma solidity ^0.8.9;

import "../internals/iB.sol";
import "../libraries/LibB.sol";

contract B is iB{
   
    

    function getOwner() external view returns (address) {
        _getOwner();
    }

    function setOwner(address _newOwner) external {
        LibB._setOwner(_newOwner);
    }
}
