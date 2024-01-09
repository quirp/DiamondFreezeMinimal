pragma solidity ^0.8.9;

contract BinaryTree {
    struct MyStruct {
        uint256 value;
        string name;
    }

    function getValue(uint16 key) public pure returns (MyStruct memory) {
        if (key < 8) {
            if (key < 4) {
                if (key < 2) {
                    if (key < 1) {
                        return MyStruct({value: 16, name: "Path 16"});
                    } else {
                        return MyStruct({value: 17, name: "Path 17"});
                    }
                } else {
                    if (key < 1) {
                        return MyStruct({value: 18, name: "Path 18"});
                    } else {
                        return MyStruct({value: 19, name: "Path 19"});
                    }
                }
            } else {
                if (key < 2) {
                    if (key < 1) {
                        return MyStruct({value: 20, name: "Path 20"});
                    } else {
                        return MyStruct({value: 21, name: "Path 21"});
                    }
                } else {
                    if (key < 1) {
                        return MyStruct({value: 22, name: "Path 22"});
                    } else {
                        return MyStruct({value: 23, name: "Path 23"});
                    }
                }
            }
        } else {
            if (key < 4) {
                if (key < 2) {
                    if (key < 1) {
                        return MyStruct({value: 24, name: "Path 24"});
                    } else {
                        return MyStruct({value: 25, name: "Path 25"});
                    }
                } else {
                    if (key < 1) {
                        return MyStruct({value: 26, name: "Path 26"});
                    } else {
                        return MyStruct({value: 27, name: "Path 27"});
                    }
                }
            } else {
                if (key < 2) {
                    if (key < 1) {
                        return MyStruct({value: 28, name: "Path 28"});
                    } else {
                        return MyStruct({value: 29, name: "Path 29"});
                    }
                } else {
                    if (key < 1) {
                        return MyStruct({value: 30, name: "Path 30"});
                    } else {
                        return MyStruct({value: 31, name: "Path 31"});
                    }
                }
            }
        }
    }
}
