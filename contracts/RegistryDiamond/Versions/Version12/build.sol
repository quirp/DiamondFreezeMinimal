pragma solidity ^0.8.9;

contract BaseBuild{
    struct FreezableParameters{

    }
    struct FacetParameters{

    }
    
}

/**
How do we manage the tooling? DApp will have upgradable architecture, likely cater it to diamonds
for simplification purposes. How do we constrain or adapt to developer's freezable experience?
Force generative design and let developers adapt. Let developers adapt seems better. They themselves
can set the external setter that WILL be removed on a freeze. All they need is the names of everything
and it's good to go. 

** Future proofing, what would need to be done if signatures changed? **
What about simplifying option? One word designates everything, i.e. variable name

setVariable1(..)external //external setter
getVariable1(..)external //external getter
_getVariable1(..)internal // internal getter
constructor( {type} _variable1){ // constructor param
    variable1 = _variable1;
}

So likely create a config file that takes an aray of freezable struct or the variable name. 
Need the variable name on-chain?
For now, all of this would determine everything needed. 
Need top level containing contract. 
struct FreezableConfig{
    variableName: parameter1,
    variableType: address,
    containingContracts : contractNameFromArtifacts[],
    UnionType (variableName or variableInterface)
}
 */