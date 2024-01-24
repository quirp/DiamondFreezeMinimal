pragma solidity ^0.8.9;

library Types{
    struct Vector{
        uint256 numVectors;
        Coordinate coordinate;
    }
    struct Coordinate{
        uint8 x; 
        uint8 y;
    }
}