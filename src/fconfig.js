let a = {
    "version": "1.12",
    "freezeables": [
        {
            "name": "tally",
            "type": "uint256",
            "value": "83",
            "frozen": true,
            "contractContainers":[
                {
                    "FacetName":"",
                    "InternalContractInitializor":"",
                    "freezeableInternalGetter" : {
                        "getterSignature":"",
                        "nonfrozenSignature":"",
                        "frozenSignature":""
                    }

                }
            ]

        }
    ]

}
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