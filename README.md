# Abstract
We introduce the concept of **freezables** and implement it in a version registry
infrastructure. 

## Freezables 

### Introduction
Scalable and versioned applications are a desirable feature for developers, and 
thanks to the [DiamondStandard](https://eips.ethereum.org/EIPS/eip-2535), a solid 
foundation has been laid out. Another desirable trait is optimization, which is 
no stranger to smart contract developers. Scalable architectures open an entire new
design space, and with that comes new approaches to optimizations. We will 
demonstrate that **freezables** are not only a way to leverage the scalable design
space for new efficiences, but showcase how the they can in some cases be **more** 
gas efficient than their non-scalable counterpart. 

### What are freezables?
Simply, freezables are variables that can be programatically transitioned back and forth between bytecode and storage. An example use case of this would be the commonly used storage variable *owner*. 
Each time *owner* is read in a transaction, it will incur a 2100 SLOAD gas cost the first time, and 100 gas subsequently. If this variable is highly trafficked and deemed *slowly* changing, it is a favourable prospect to exist as a freezable variable (as ultimately this is a sacrifice by the developer for the consumer's sake in all likelihood). 

### How are freezables implemented?
This still isn't obvious to me at the time of writing. What started out as a question
in build tooling for the freezables concept, took a hefty detour into a specific implementation just to bring it to fruition. Some of the decisions/constraints that
led to this are as follows:

1. Must be upgradeable to implement freezables to your application. 
2. If we imagine we have *n* freezable variables as a binary vector, which we denote the **state vector** of length *n*, we can realize each non-zero bit as a flag for the *i*th slot variable as being frozen (hardcoded), while a zero denoting the variable lives in storage. Having the **state vector and it's associated types on-chain is both important for verificaiton tools and client security respectively**. 
3. Given this condition, anytime our Dapp upgrades its version, we could potentially be changing the statespace (growing, shrinking, type change). In order to accomodate this, we'd also need a way to track this. 
4. This leads us to 

5. 
6. In the scalable implementation we also include a registry service. This provides a dual purpose: 
1. Allows for 3rd party verification: Given a given freezeable ...
2. Enables reusability, lowering the costs transitioning a freezeable. 

 The number of Diamond configurations given  \`\`\` 2*N <= SIZE <= N^2 \`\`\` where,
    a. 2*N if all the freezables exclusively exis in seperate facets
    b. N^2 if every pair of freezables exist in at least one facet.  
    (Dependency meaning they exist in the same facet or not)