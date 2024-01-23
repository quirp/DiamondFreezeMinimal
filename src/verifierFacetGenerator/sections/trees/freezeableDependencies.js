const fs = require("fs")
//StructMap is a tuple, ( uint16,(bytes2,bytes32) )
function freezeableDependencyTree(contractDependencyMap){
    /**
     * takes mapping array and returns middle index
     * 
     */
    function findMedian(_contractDependencyMap){
        const _mapLength = _contractDependencyMap.length;
        return  Math.floor(_mapLength/2)
    }
    function generateConditional(_reducedMap){
        let _newSegment = "";
        if(_reducedMap.length >= 2){
            let _middleIndex = findMedian(_reducedMap);
            let _medianValue = _reducedMap[_middleIndex][0];
            //top branch
            _newSegment = _newSegment.concat(` if(${_medianValue} >= _freezeableIndex)\n {`)
            _newSegment = _newSegment.concat(generateConditional( _reducedMap.slice(_middleIndex)) )
            _newSegment = _newSegment.concat ("}\n")

            //bottom branch
            _newSegment = _newSegment.concat("else{")
            _newSegment = _newSegment.concat(generateConditional( _reducedMap.slice(0,_middleIndex)) )
            _newSegment = _newSegment.concat("}\n")
        }
        else if ( _reducedMap.length == 1 ){
            _newSegment = _newSegment.concat(`if( ${_reducedMap[0][0]} == _freezeableIndex)\n{ return (${_reducedMap[0][1][0]}, ${_reducedMap[0][1][1]} );}\n`)
        }
        else{
            _newSegment = _newSegment.concat("")
        }
        return _newSegment
    }
    //Tree structure
    let tree = "function freezeableVariableDependencies( uint8 _freezeableIndex) internal returns() {";
    let newSegment = generateConditional(contractDependencyMap) 
    tree = tree.concat(newSegment);
    tree = tree.concat("revert MalformedBinaryTree();")
    tree = tree.concat("}")
    return tree;
}
module.exports = {freezeableDependencyTree}

// let sampleArray = [
//     [123, ['0xABCD', '0x1234567890123456789012345678901234567890123456789012345678901234']],
//     [45, ['0xCDEF', '0x5678901234567890123456789012345678901234567890123456789012345678']],
//     [78, ['0xEF01', '0x9012345678901234567890123456789012345678901234567890123456789012']],
//     [101, ['0x1203', '0x3456789012345678901234567890123456789012345678901234567890123456']],
//     [202, ['0x2304', '0x6789012345678901234567890123456789012345678901234567890123456789']],
//     [30, ['0x3405', '0x9012345678901234567890123456789012345678901234567890123456789012']],
//     [40, ['0x4506', '0x1234567890123456789012345678901234567890123456789012345678901234']],
//     [50, ['0x5607', '0x5678901234567890123456789012345678901234567890123456789012345678']],
//     [66, ['0x6708', '0x9012345678901234567890123456789012345678901234567890123456789012']],
//     [77, ['0x7809', '0x3456789012345678901234567890123456789012345678901234567890123456']]
//   ];
//   sampleArray.sort((a, b) => a[0] - b[0]);
//   console.log(sampleArray)
//   console.log( binaryTreeGenerate(sampleArray) )
