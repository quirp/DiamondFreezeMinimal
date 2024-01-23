const fs = require("fs")
//StructMap is a tuple, ( uint16,(bytes2,bytes32) )
function facetDependencyTree(facetDependencyMap,test=false){
    /**
     * takes mapping array and returns middle index
     * 
     */
    function findMedian(_facetDependencyMap){
        const _mapLength = _facetDependencyMap.length;
        return  Math.floor(_mapLength/2)
    }
    function generateConditional(_reducedMap){
        let _newSegment = "";
        if(_reducedMap.length >= 2){
            let _middleIndex = findMedian(_reducedMap);
            let _medianValue = _reducedMap[_middleIndex][0];
            //top branch
            _newSegment = _newSegment.concat(` if(${_medianValue} >= _contractIndex)\n {`)
            _newSegment = _newSegment.concat(generateConditional( _reducedMap.slice(_middleIndex)) )
            _newSegment = _newSegment.concat ("}\n")

            //bottom branch
            _newSegment = _newSegment.concat("else{")
            _newSegment = _newSegment.concat(generateConditional( _reducedMap.slice(0,_middleIndex)) )
            _newSegment = _newSegment.concat("}\n")
        }
        else if ( _reducedMap.length == 1 ){
            _newSegment = _newSegment.concat(`if( ${_reducedMap[0][0]} == _contractIndex)\n{ return (${_reducedMap[0][1][0]} } );}\n`)
        }
        else{
            _newSegment = _newSegment.concat("")
        }
        return _newSegment
    }
    /**
     * Want to split all in half < , >=
     * Then repeat until no more splits
     * Should end on an if or nothing for 
     * leaves
     * 
     * 
     */

    /**
     * 
     */
    let tree = `function tree( uint16 _facetIndex) ${test ? "external": "internal"} returns(bytes32) {`;
    let newSegment = generateConditional(facetDependencyMap) 
    tree = tree.concat(newSegment);
    tree = tree.concat("revert MalformedBinaryTree();")
    tree = tree.concat("}")
    return tree;
}

module.exports = {facetDependencyTree}
// let sampleArray = [
//     [123, [ '0x1234567890123456789012345678901234567890123456789012345678901234']],
//     [45, ['0x5678901234567890123456789012345678901234567890123456789012345678']],
//     [78, ['0x9012345678901234567890123456789012345678901234567890123456789012']],
//     [101, [ '0x3456789012345678901234567890123456789012345678901234567890123456']],
//     [202, [ '0x6789012345678901234567890123456789012345678901234567890123456789']],
//     [30, ['0x9012345678901234567890123456789012345678901234567890123456789012']],
//     [40, ['0x1234567890123456789012345678901234567890123456789012345678901234']],
//     [50, ['0x5678901234567890123456789012345678901234567890123456789012345678']],
//     [66, ['0x9012345678901234567890123456789012345678901234567890123456789012']],
//     [77, ['0x3456789012345678901234567890123456789012345678901234567890123456']]
//   ];
//   sampleArray.sort((a, b) => a[0] - b[0]);
//   console.log(sampleArray)
//   console.log( binaryTreeGenerate(sampleArray) )
