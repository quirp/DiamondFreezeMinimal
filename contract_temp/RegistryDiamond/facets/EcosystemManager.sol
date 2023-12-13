pragma solidity ^0.8.9;

contract EcosystemManager{
    struct Ecosystem{
        bool isDisabled;
        address ecosystemAddress;
        uint256 version; 
        //address is the key to parameters
    }
    struct EcosystemManage{
        uint8 primaryEcosystemIndex;
        Ecosystem[] ecosystems;
    }
    function disableEcosystem(uint8 ecosystemIndex)external{}
    function removeEcosystem(uint8 ecosystemIndex)external {}
    function 
}