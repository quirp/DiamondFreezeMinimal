const constants = (amountFreezeableFacets,amountFreezeableVariables)=>{
   return ```
uint16 constant AMOUNT_FREEZEABLE_FACETS = ${amountFreezeableFacets};
uint8 constant AMOUNT_FREEZEABLE_VARIABLES = ${amountFreezeableVariables};
   ```
} 

module.exports = {constants};