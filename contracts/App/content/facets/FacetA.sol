pragma solidity ^0.8.9;

import "../internals/iA.sol";
import "../libraries/LibA.sol";
contract A is iA{
    function addToMarketFee(uint256 _a) external view returns (uint256){
        _addToMarketFee(_a);
    }
    function getMarktFee() external view returns (uint256){
        _getMarketFee();
    }
    function setMarketFee(uint256 _newMarketFee) external {
        LibA._setMarketFee(_newMarketFee);
    }
}