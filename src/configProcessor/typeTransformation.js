/**
 * Recursively takes in a solidity type and generate a corresponding
 * object struct and object value representative. 
 */
function typeTransformation(){
    /**
     * Strategy is to handle solidity types first, then user defined types
     * (enums,structs) -user defined types handled last, checks AST for type.
     * check for array firstly, no mappings.
     * 
     * * Users enter struct types just as they would when instantiating.
     *   
     * Procedure: 
     * Check if array
     *      isFixed, if so get length
     *      Strip array delimiter and recurse
     * Check if primitive 
     * Check if user defined
     * 
     * So we need to construct a type object such that it's easy to instantiate that
     * object for a transaction
     * 
     * For arrays we simply create array 
     * {type:array } OR {type:fixedArray}
     * So we basically create a parser and then filter inside the freezeable module scope
     */
}