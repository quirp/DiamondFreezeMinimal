pragma solidity ^0.8.9;

import "../libraries/LibA.sol";

abstract contract MarketFee {
    function _getMarketFee() internal view virtual returns (uint256);

    function _getMarketFeeUF() internal view returns (uint256) {
        return LibA._getMarketFee();
    }
}
