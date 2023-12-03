pragma solidity ^0.8.9;

import "../internals/iParameter3.sol";
import "../libraries/Lib3.sol";
contract Third is iThird{
    function getParameter3() external view returns (uint256){
        _getVariable3();
    }
    function setParameter3(uint256 _parameter3) external {
        Lib3._setParameter3(_parameter3);
    }
}

/**
 * Do we need an entire registry? No, we could forget all the registry nonsense
 */