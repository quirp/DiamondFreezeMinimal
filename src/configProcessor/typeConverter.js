/**
 * Assists in asserting user entered js type's values will
 * work in the soldity environment. 
 */

const typeConversionMap = {
    uint: convertUnsignedInteger,
    int: convertSignedInteger,
    bool: convertBool,
    address: convertAddress,
    bytes: convertBytesFixed,
    string: convertString,
    bytesDynamic: convertBytesDynamic,
    array: convertToArray,
    struct: convertToStruct,
    enum: convertToEnum
}
const isPrimitive = {
    uint: true,
    int: true,
    bool: true,
    address: true,
    bytes: true,
    string: false,
    bytesDynamic: false,
    array: false,
    struct: false,
    enum: false
}

/**
 * 
 * @param {BigInt} unsignedInteger 
 * @returns {BigInt | }
 */
function convertUnsignedInteger(unsignedInteger) {
    if (unsignedInteger < 0) {
        throw Error("Value must be NonNegative.")
    }
    if (unsignedInteger < Number.MAX_SAFE_INTEGER) {
        return Number(unsignedInteger);
    }
    if (unsignedInteger >= BigInt(2 ** 256)) {
        throw Error("Value is greater than 2**256 - 1")
    }
    return unsignedInteger;
}
/**
 * Converts a signed integer from Solidity to JavaScript.
 * @param {BigInt} signedInteger The signed integer to convert.
 * @returns {number | BigInt} The converted signed integer.
 */
function convertSignedInteger(signedInteger) {
    if (signedInteger >= BigInt((-1) * 2 ** 255) && signedInteger < BigInt(2 ** 255)) {
        return (signedInteger >= BigInt(-Number.MAX_SAFE_INTEGER) && signedInteger <= Number.MAX_SAFE_INTEGER)
            ? Number(signedInteger)
            : signedInteger;
    }
    throw new Error("Value is out of the int256 range");
}

/**
 * Converts a Solidity boolean to a JavaScript boolean.
 * @param {boolean} boolValue The boolean value to convert.
 * @returns {boolean} The converted boolean value.
 */
function convertBool(boolValue) {
    return Boolean(boolValue);
}

/**
 * Converts a Solidity address to a JavaScript string.
 * @param {string} address The address to convert.
 * @returns {string} The converted address as a string.
 */
function convertAddress(address) {
    // Assuming the address is already in a valid hexadecimal string format
    return address;
}

/**
 * Converts a fixed-length bytes array from Solidity to a JavaScript string or Uint8Array.
 * @param {string} bytesFixed The fixed-length bytes array to convert.
 * @returns {string | Uint8Array} The converted bytes array.
 */
function convertBytesFixed(bytesFixed) {
    // Assuming the input is a hexadecimal string
    return bytesFixed.startsWith('0x') ? bytesFixed : new Uint8Array(Buffer.from(bytesFixed, 'hex'));
}

/**
 * Converts a Solidity string to a JavaScript string.
 * @param {string} str The string to convert.
 * @returns {string} The converted string.
 */
function convertString(str) {
    return str;
}

/**
 * Converts a dynamically-sized bytes array from Solidity to a JavaScript string or Uint8Array.
 * @param {string} bytesDynamic The dynamically-sized bytes array to convert.
 * @returns {string | Uint8Array} The converted bytes array.
 */
function convertBytesDynamic(bytesDynamic) {
    // Assuming the input is a hexadecimal string
    return bytesDynamic.startsWith('0x') ? bytesDynamic : new Uint8Array(Buffer.from(bytesDynamic, 'hex'));
}

/**
 * Converts an array, recursively applying the converter function to each element.
 * @param {Array} array The array to convert.
 * @param {Function} converter The function to convert array elements.
 * @returns {Array} The converted array.
 */
function convertToArray(array, converter) {
    return array.map(element => {
        if (Array.isArray(element)) {
            // Recursive call for nested arrays
            return convertToArray(element, converter);
        } else if (typeof element === 'object' && element !== null) {
            // Recursive call for nested objects (like structs)
            return converter(element);
        } else {
            return converter(element);
        }
    });
}


/**
 * Recursively converts a Solidity struct to a JavaScript object.
 * @param {Object} struct The struct to convert.
 * @param {Object} structConversionMap A mapping of struct fields to their conversion functions.
 * @returns {Object} The converted object.
 */
function convertToStruct(struct, structConversionMap) {
    let convertedStruct = {};
    for (let key in struct) {
        if (struct.hasOwnProperty(key)) {
            // Apply appropriate conversion based on expected type
            const converter = structConversionMap[key];
            if (typeof converter === 'function') {
                convertedStruct[key] = converter(struct[key]);
            } else {
                // If no specific converter, default to direct assignment
                convertedStruct[key] = struct[key];
            }
        }
    }
    return convertedStruct;
}

/**
 * Converts a Solidity enum to a JavaScript representation.
 * @param {number} enumValue The enum value to convert.
 * @returns {number} The converted enum value.
 */
function convertToEnum(enumValue) {
    // Assuming enums are represented as integers
    return enumValue;
}
