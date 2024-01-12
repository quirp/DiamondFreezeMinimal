pragma solidity ^0.8.9;

import "../freezeables/MarketFee.sol";
contract iA is MarketFee{
    uint256 constant private marketFee = 3;

    function _getMarketFee() internal view override returns (uint256){
        return marketFee;
    }
    
    function _addToMarketFee(uint256 a) internal view returns (uint256){
        return a + _getMarketFee();
    }


  
}
/**
 * store the un-frozen function as a seperate name, private. 
 * frozen function is removed as it can be generated. 
 * can use a top layer function if needed. 
 * 
 * 
 */