// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrimitiveTypesContract {
    struct B {
        uint256 b;
        bytes _bytes;
    }
    struct A {
        B _b;
    }
    //Struct
    A _struct = A(B(9,hex"01"));

    // Unsigned Integer
    uint256 public unsignedInteger;

    // Signed Integer
    int256 public signedInteger;

    // Boolean
    bool public booleanVariable;

    // Address
    address public owner;

    // String
    string public stringValue;

    // Bytes
    bytes public bytesData;

    // Dynamic Array of Unsigned Integers
    uint256[] public dynamicArray;

    // Fixed Size Array
    uint256[5] public fixedArray;

    //Fixed String
    string[3] public string_;
    // Mapping
    mapping(uint256 => string) public mappingExample;

    // Enum
    enum ExampleEnum {
        Option1,
        Option2,
        Option3
    }
    ExampleEnum public enumVariable;

    // Constructor
    constructor() {
        // Assign initial values
        unsignedInteger = 42;
        signedInteger = -10;
        booleanVariable = true;
        owner = msg.sender;
        stringValue = "Hello, Solidity!";
        bytesData = hex"deadbeef";
        dynamicArray = [1, 2, 3];
        fixedArray = [4, 5, 6, 7, 8];
        mappingExample[1] = "First Option";
        enumVariable = ExampleEnum.Option1;
    }
}
