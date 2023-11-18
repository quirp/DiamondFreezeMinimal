pragma solidity ^0.8.9;

contract FreezableRegistry{

   
    function freezableInit() external {
        //should set merkle root for configurations
        //should set initial state
    }
    function upgradeFreezable() external {

    }
    function getFreezables() external view {
        // Needs to access the function selectors from storage. 
        // Need to decide on type of contract at this point
        // Static vs Diamond 
        // Static implies a static registry, which might not be ideal
        // Static registry implies static typing 
        // Dynamic typing enabled through diamonds 
        // Dynamic 
       
    }

}