pragma solidity ^0.8.9;

import "../internals/iFreezable.sol";
import "../libraries/LibDiamond.sol";

contract Freezable is iFreezable{

    function freezableManage(DiamondCut[] calldata _diamondCut,address _init, bytes calldata _data, Lib.Freezable memory freezable) external {
        _freezableManage(_diamondCut, _init, _data, _freezable);
    }

}
/**
When dealing with a new statespace, we're having trouble doing this atomically. 
The issue is how do we call a contract without it being added to the interface yet.
No that's not it. We just need to cut new version in, and initialize. 
So we'd do cuts first then verify after? Or we double back after being in the facet. 
Very ugly.

Cut first through a freezable cut interface.
then verify.
This freezable interface cant depend on the freezable struct. 
The issue is when you have calldata, the only natural way to parse it in solidity is via calling
the respective function it was designed for.
So what if the freezable interface calls this new version, and this new version then takes care of the rest. 

How to do this? We do a double call or call straight to the new version?
Calling straight to a new version would need something else at the diamond level, else double call. 
facetCut then initialization to version?
Or call the previous contract?
Have a special facet for dealing with freezableversion handling. no dependencies on freezableVersion. Makes another call to new version if needed. 
 */