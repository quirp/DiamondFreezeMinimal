const {ethers}= require('ethers')
function structToSignatures(_freezableParamMap){
    for( let[paramName,paramVal] of _freezableParamMap){
        ethers.utils.defaultAbiCoder.encode([])
    }
}