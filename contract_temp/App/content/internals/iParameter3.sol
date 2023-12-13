pragma solidity ^0.8.9;

import "../libraries/Lib2.sol";
import "../libraries/Lib3.sol";
contract iThird {
    address immutable owner;

    constructor(address _owner) {
        owner = _owner;
    }
function _getFunction2() internal view returns (address) {
        return Lib2._getParameter2();
    }
    function _getFunction() internal view returns (bytes4) {
        return Lib3._getParameter3();
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
