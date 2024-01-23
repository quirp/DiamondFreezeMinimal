const ERRORS = `error InvalidFreezableFacetIndex(bytes2); 
error VerificationFailed(address, bytes2, bytes); 
error NonFreezeableVerification(address, bytes2, bytes);
error InvalidFreezableCut(bytes32);
error InvalidVerifierArrayLengths(uint16, uint16);
`

module.exports = {ERRORS};