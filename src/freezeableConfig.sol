pragma solidity ^0.8.9;

/**
 * @title Freezeable Variable configuration
 * @author 
 * @notice Create your freezeable variables 
 */
contract Dummy{
    struct Bounds{
        uint8[2] bounds;
        bool active;
    }
    uint256 marketFee = 30;
    address owner =0x742d35Cc6634C0532925a3b844Bc454e4438f44e;
    bytes4 forbiddenSelector;
    Bounds bounds = Bounds([2,3],true);
    /**
     * Instantiate your freezeables as if they're in storage, tooling will 
     * convert it to the appropriate hardcoded state for the transformed contracts. 
     * I.e. the bounds variable will be converted to the following,
     
    function bounds() internal pure returns( Bounds memory ){
       return Bounds([2,3],true);
      }
      
      if the designated internal getter for this function is "bounds".
       * 
       */
}