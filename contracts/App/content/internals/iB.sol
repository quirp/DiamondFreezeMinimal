pragma solidity ^0.8.9;

import "../freezeables/Owner.sol";
contract iB is Owner{
    address constant private owner = 0x742d35Cc6634C0532925a3b844Bc454e4438f44e;


    function _getOwner() internal view override returns (address) {
        return owner;
    }

    function moderatedAccessor() internal view {
        require(msg.sender == _getOwner(), "Must match the owner's address");
        //do some extremeley important stuff
    }
}

/**
    Need :
        - Internal Contract Name (iParameter2)
        - Internal Getter Signature( _getParameter2())
        - External Setter Signature ( setParameter2(address))
        - External Getter Signature  (getParameter2())
 */

// contract iParameter2Frozen{
//     address immutable owner;
//     address immutable parameter2;
//     constructor(address _owner, address _parameter2){
//         owner = _owner;
//         parameter2 = _parameter2;
//     }
//     function _getParameter2() internal view returns (address) {
//         return parameter2;
//     }
// }
