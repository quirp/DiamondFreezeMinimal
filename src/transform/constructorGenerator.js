/**
 ****** Don't need any of this for the minimal implementation *****
All of this can be done by generating constants in the apporiate internal
contract. 


 * Generates constructor changes for when a freezebale changes state.
 * Convention is added underscore to freezeable name as a constructor parameter
 * 
 * At this stage of calling sequence, we have he config file and are inputted a 
 * state vector. We check that EVERY freezeable has or doesn't have a constructor 
 * param in the appropriate spots. 
 * 1. LOOP OVER FREEZEABLES 
 * 2. Load in first external file (else load it from cache in Map)
 * 3. Create or Destroy nested constructor params and their corresponding 
 *      declarations and definitions. 
 *    - To do this format the file after parsing. 
 *    - When making an edit, save it in an array. This is done so we can do all
 *      of the editing at once and keep track of the cursor by editing the lowest
 *      line number first and incrementing from there (or just reformat?)
 *    - Potentially create a diff file output for a user display. 
 */

function _getA() internal returns (uint256){
    return a;
}

function _getA() internal returns (uint256){
    return a();
}
/*
* Need one singular function to access variable.  
  Then need two functions for frozen and non-frozen getter.
  User can just add another layer of logic if needed, but this would make it 
  Make a frozen and non-frozen getter function
*/