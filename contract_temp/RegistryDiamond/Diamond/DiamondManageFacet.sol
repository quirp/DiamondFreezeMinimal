pragma solidty ^0.8.9;

import "../interfaces/IDiamondManage.sol";

import "../internals/iDiamondCut.sol";
import "../internals/iFreezable.sol";

contract DiamondManageFacet is IDiamondManage , iDiamondCut,  iFreezable {
    error InvalidFreezableAction(IDiamondManage.FreezableAction);
    function diamondManage(
        FacetCut[] memory _facetCut,
        address _init,
        bytes calldata _data,
        Freezable calldata _freezable
    ) external override {
        _diamondCut(_facetCut, _init, _data);
        if( _freezable.action == FreezableAction.None){
            //
        }
        else if(_freezable.action == FreezableAction.Transform){
            transform(_freezable);
        }
        else if(_freezable.action == FreezableAction.New){
            //check new address exists
            //
        }
        else if(_freezable.action == FreezableAction.Remove){
            
        }
        else{
            revert InvalidFreezableAction(_freezable.action);
        }
        //XOR transform vectors, make sure initialized already 
    }
}

///needs to be a new version.. Otherwwise we're doing some very cheasy safety/security checks
// Needs to keep something on-chain to keep off-chain in check. 
// On New, must upload new version . 
// This verison contract contiains state variables and facet dependencies. 
// transition logic? mapping from one state space to another and the checks we can perform on it.
/**
Is this more burdensome than helping?
Might be better to leave transition logic to users. As there's really no real utility the on-chain
can help with data consistency other than user uploading a mapping of state spaces.
How do we even generally test for data equality, given our generatable data types?
can verify on chain before storage, and abi encode hash it

zksnarks 


 So we keccak256 ( abi.encode( )), do we need types at all? Just vector slots and params. 


What does freezable action need to do, Transform, New, Remove

How are we integrating/separating the freezables from facets? 
Want consistency. No way to know which selectors are going to be in a new freezable version, so can't control or check that. 
Also user can remove access to getters/setters? Why would they need to do that? Should likely either have the version online
as one block or not at all. No way to block facetCut adding a version though. 
Doesn't seem like there's a way to communicate on-chain what is freezable selector or facet, so can't worry about it. 

What about keep facets seperate and create a special built-in for freezables?
It doesn't seem like there's much sense in trying to enforce consistency in cuts conflicting with freezables. 
So just scrap that idea. Keep them seperate. Create a freezeable Cut? 
Why need a seperate cut and not just a facet?


So we always call the main freezable function which takes Freezable. But we don't know the address of the new freezable. 
That's why diamondCut would handle it all. Seems like it would be a good idea to assert a freezables don't overwrite eachother. 
To do this we'd need a placeholder for a freezable address. Why not put the protection inside the freezable facet?
So on initialization from a diamondCut (which it would have to be). Having a facetCut within a facet seems a bit strange?
I think another way is to have a constant function that intercepts the selector.
Sacrifice upgradablity vs optimized (diamond constant selector vs a facet that manages the logic)

I think we create a new facet and inherit the diamond cut. We can then use address(this) to retrieve the current address.
But how are we cutting all the new contracts needed? Seems like we need a freezable cut such that it performs freezable logic 
but also subcalls facetCut.

This way facet cutting is still seperated and can be used as normal. Also we would want to designate a particular storage slot
for the freezable, so it can't be changed by a diamondCut external. Need to think of a way to seperate the two cuts but make them
consistent. Consistency basically means they don't effect each other's storage. It seems like a constraint could be
Diamond Cut's (DC) should never contain the same address or selector as in FreezableCut (FC), and vice versa. Could check if non-zero
entry in either's storage, if so revert. But would need to selectors as well. 

So we could hardcode FC selector? If we did then we'd need to protect it from ever being changed. Not difficult. 

When cutting freezable, check make sure not effecting others. 
We should keep freezable and diamond in the same storage, but have a specific pointer to freezable. 
How do we stop diamondCut from effecting freezable status? Would need to have a builtin check for particular 
seperate storage. Separating seems better, but using similar.

Is there a way to encode address/selector information into 32bytes such that one read can be done to test inclusion
create a separate storage, freezable storage with selectors. Not really without extra overhead. 

Storage must be checked for conflicting items. If you plan to scale would want different mechanism of verify conflicts anyway. 
So seperate storages, checks. That's it. 

So freezable and diamond have their own storage, and check each other.
only change to diamondCut is checking freezable storage


Do they need to be separated? Why would we need to know which are freezables. So a diamondCut can't override it when called externally. 
We need to know what we're not supposed to be overwriting. In order to do this we need way to lookup matching selectors. 

So when freezeCut called, we change storage subject to it doesn't collide with the Diamond. 
Better to just replace diamondCut. Circle back to diamondManage :D. 


diamondManage should have way to check if a facet has a variable in the freezable state space. 
So we create an bit map address => bool.
Also how to make it scalable? For now just retrieve one-by-one. 


 */