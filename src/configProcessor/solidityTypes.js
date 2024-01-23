/**
 * asserts freezeable type/value object 
 */
const { typeConversionMap, isPrimitive } = require("./typeConverter.js")

uintMatcher = /^uint(8|16|24|32|40|48|56|64|72|80|88|96|104|112120||128|136|144|152|160|168|176|184|192|200|208|216|224|232|240|248|256)$/
intMatcher = /^int(8|16|24|32|40|48|56|64|72|80|88|96|104|112|120|128)$/
bytesMatcher = /^bytes(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32)$/
const REGEX_FIXED_ARRAY = /\[\d{1,5}\]$/
const REGEX_FIXED_ARRAY_SIZE = /\[(\d{1,5})\]$/

function mainTypeHandler(variableData) {
    let a = typeAsserter(variableData)
    generator(a)
}
/**
 * Need to assert the freezeable solidity type, assert proper values,
 * generate code snippets for that freezeable
 * @param {*} variableData 
 */
function typeAsserter(variableData) {
    let variableType;
    if (REGEX_FIXED_ARRAY.match(variableData.type)) {
        variableType = "fixedArray"
    }
    else if (variableData.type == 'struct') {
        variableType = variableData.type
    }
    else {
        let uintMatch = variableData.type.match(uintMatcher);
        if (uintMatch) {
            uintMatch
        }
    }
    //isFixedArray
    //isPrimitive
    //is
    switch (variableType) {
        case "uint":
            return [isPrimitive["uint"], typeConversionMap["uint"](variableData.value)]
        case "int":
            return [isPrimitive["int"], typeConversionMap["int"](variableData.value)]
        case "bytes":
            return [isPrimitive["bytes"], typeConversionMap["bytes"](variableData.value)]
        case "address":
            return [isPrimitive["address"], typeConversionMap["address"](variableData.value)]
        case "bool":
            return [isPrimitive["bool"], typeConversionMap["bool"](variableData.value)]
        case "fixedArray":
            let arrayType = REGEX_FIXED_ARRAY.match(variableData.type)[1]
            return [isPrimitive["array"], typeConversionMap["array"]]
        case "struct":
            return [isPrimitive["struct"],]
        //
        default:
            throw Error("Unknown freezeable type - ", variableData.type)
    }
}

function generator(variableData) {
    /**
     * Needs to know if primitive or function freezeable instantation
     * 
     */
    if (isPrimitive) {
        function freezeablePrimitiveInstantiation(freezeableName) {
            return `${variableType.type} constant private ${freezeableName} =  ${variableType.value};`
        }
    }
    else {
        return `return ${variableType.value};`
    }
}

function typeObjectKeyValidation() {
    /**
     * properly formatted object
     */
    if (variableData.)
}

function fixedArray(variableData) {
    let arrayType = REGEX_FIXED_ARRAY.match(variableData.type)[1]
    let arraySize = REGEX_FIXED_ARRAY_SIZE.match(variableData.type)


}
/**
 * Must be handled seperately due to recursive nature
 */
function nestedTypeHandler(variableData) {
    if (variableData.type == 'struct') {
        if (variableData.has('structName')) {
            for (let structMember of variableData.value) {
                return typeHandler(structMember)
            }
        }
        else {
            throw Error("Missing property structName of variable type struct", variableData)
        }
    }
    else if (REGEX_FIXED_ARRAY.test(variableData.type)) {
        let arrayType = REGEX_FIXED_ARRAY.match(variableData.type)
        let arraySize = REGEX_FIXED_ARRAY_SIZE.match(variableData.type)

    }
    else {
        throw Error("Unhandled Nested case.", variableData)
    }
}

const variableData = {
    variable1: { type: 'uint256', value: '12345678901234567890' },
    variable2: {
        type: 'struct', isStruct: true, value: {
            nested1: { type: 'string', value: 'Nested String' },
            nested2: { type: 'bool', value: false },
        }
    },
    variable3: { type: 'address', value: '0x742d35Cc6634C0532925a3b844Bc454e4438f44e' },
    variable4: {
        type: 'uint256[5]', value: {
            type: 'uint256', value: false,
            type: 'uint256', value: false,
            type: 'uint256', value: false,
            type: 'uint256', value: false,
            type: 'uint256', value: false
        }
    },
        //or
        { type: 'A[5]', value: }

    },
variable5: {
    type: 'A[2]', value: {
        type: 'struct', structName: "A", value: {
            type: 'B[2]', value : {
                type: "struct", structName: "B", value : {
                    bool: true
                },
                type: "struct", structName: "B", value : {
                    bool: false
                }
            },
            type: 'B[2]', value : {
                type: "struct", structName: "B", value : {
                    bool: false
                },
                type: "struct", structName: "B", value : {
                    bool: true
                }
            }
        }
    }
}
};

/**
 * variable5 generated output:
 *  function {freezeableGetter} ( ) internal view returns(A[2] memory){
 *      return  [ A( [ B(true), B(false) ] ), A([ B(false), B(true)])
 * } 
 */

/**
 * Algorithim:
 * 1. Top level type always is the return type. 
 * 2. Fixed array of type A, size n-> [A_1(...),...,A_n(...)], so:
 *      [
 *      for (elements){
 *          A(
 *          typeAsserter(elements)
 *          )
 *      }
 *      ]
 */