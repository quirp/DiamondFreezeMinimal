let config = {
    "version": "1.12",
    "solConfig": "./",
    "facetVerifierSignatures":{
        "A":"verifierA()",
        "B":"verifierB()",
        "C":"verifierC()"
    },
    "freezeables": [
        {
            "name": "marketFee",
            "value": 349,
            "type": "uint256",
            "isFrozen": true,
            "contractContainers":[
                {
                    "facetName":"A",
                    "freezeableInitializorContractName":"iA",
                    "freezeableInternalGetter" : {
                        "getterSignature":"_getMarketFee()",
                        "nonfrozenSignature":"_getMarketFeeUF()",
                        
                    },
                    

                }
            ]

        },
        {
            "name": "owner",
            "value": '0x742d35Cc6634C0532925a3b844Bc454e4438f44e',
            "type": "address",
            "isFrozen": true,
            "contractContainers":[
                {
                    "facetName":"B",
                    "freezeableInitializorContractName":"iB",
                    "freezeableInternalGetter" : {
                        "getterSignature":"_getOwner()",
                        "nonfrozenSignature":"_getOwnerUF()",
                        
                    },
                    

                },
                {
                    "facetName":"C",
                    "freezeableInitializorContractName":"iC",
                    "freezeableInternalGetter" : {
                        "getterSignature":"_getOwner()",
                        "nonfrozenSignature":"_getOwnerUF()",
                        
                    },
                    

                }
            ]

        },
        {
            "name": "forbiddenSelector",
            "value": "",
            "type": "bytes4",
            "isFrozen": false,
            "contractContainers":[
                {
                    "facetName":"C",
                    "freezeableInitializorContractName":"iC",
                    "freezeableInternalGetter" : {
                        "getterSignature":"_getForbiddenSelector()",
                        "nonfrozenSignature":"_getForbiddenSelectoUF()",
                        
                    },
                    

                }
            ]

        },
        {
            "name": "bound",
            "value": "",
            "type": "uint8[4]",
            "isFrozen": true,
            "contractContainers":[
                {
                    "facetName":"C",
                    "freezeableInitializorContractName":"iC",
                    "freezeableInternalGetter" : {
                        "getterSignature":"_getBound()",
                        "nonfrozenSignature":"_getBoundUF()",
                        
                    },
                    

                }
            ]

        }
    ]

}
module.exports = {config}
/**
 * How do we concoct the previous state? What must remain the same?
 * Freezable name.
 * Previous freezeable state is quite literally this file. 
 * New states can be generated from the UI or a new config file.
 * Now transformations vs New, what cant change?
 * 
 * Transformations:
 *      - Freezeable index
 *      - Freezeable type
 *      - Facet Index
 * Just reevaluate the current state each time, no need to worry about changes
 * Assert current state exists, else throw error stating where there's a discrepancy. 
 * Locally we can reset state to a given state or transform, new.
 */