```
    pragma solidity ^0.8.9;

    contract StructDummy{

        struct A{
            uint256 a;
            B[] b;
        }
        struct B{
            bool active;
        }

        function hardcodedInstanceA() internal pure returns (A memory){
            return A(10,B([true,false,true]));
        }
    }
```
The user would then enter the following as the type, value in the config file,

```
    {
        'type': "A",
        'value':  "A(10,B([true,false,true]))"
    }
```
 a verbatim copy of the instantiated user generated type. 



