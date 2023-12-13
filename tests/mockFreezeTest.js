const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DummyFreezableContract", function () {
    let dummyContract;
    let accounts;
    let defaultState;
    let initialStateVector;

    beforeEach(async function () {
        const DummyFreezableContract = await ethers.getContractFactory("DummyFreezableContract");
        dummyContract = await DummyFreezableContract.deploy();
        accounts = await ethers.getSigners();

        // Set a default state for testing
        defaultState = {
            userAddress: accounts[0].address,
            lowerAmount: 100,
            upperAmount: 200,
            a: true,
            b: false
        };
        //set initial freezable state
        const flag = 16;
        initialStateVector = ethers.encodeBytes32String(flag.toString())
    });

    it("should initialize with default values", async function () {
        await dummyContract.initialize(defaultState,initialStateVector);

        const _initialStateVector = await dummyContract.getFreezableState();

        expect(_initialStateVector).to.equal(initialStateVector);
        console.log(3)
    });

    it("should update state and run equalityComparison without error", async function () {
        // Set initial states for comparison
        await dummyContract.setPreviousState(/* previous state value */);
        await dummyContract.setNewState(/* new state value */);

        // Update the state to a new valid state
        const newState = {
            userAddress: accounts[1].address,
            lowerAmount: 150,
            upperAmount: 250,
            a: false,
            b: true
        };

        await dummyContract.updateState(
            newState.userAddress,
            newState.lowerAmount,
            newState.upperAmount,
            newState.a,
            newState.b
        );

        // Verify the updated state
        const updatedState = await dummyContract.getFreezableState();
        expect(updatedState.userAddress).to.equal(newState.userAddress);
        expect(updatedState.lowerAmount).to.equal(newState.lowerAmount);
        expect(updatedState.upperAmount).to.equal(newState.upperAmount);
        expect(updatedState.a).to.equal(newState.a);
        expect(updatedState.b).to.equal(newState.b);
    });

    it("should revert on invalid state update", async function () {
        // Set initial states for comparison
        await dummyContract.setPreviousState(/* previous state value */);
        await dummyContract.setNewState(/* new state value */);

        // Attempt to update to an invalid state
        await expect(dummyContract.updateState(
            accounts[2].address, // invalid userAddress
            999,                // invalid lowerAmount
            999,                // invalid upperAmount
            true,               // invalid a
            false               // invalid b
        )).to.be.revertedWith("User inputted dependent state vector component doesn't match the previous state's counterpart");
    });

    // Additional tests as needed for different scenarios and edge cases
});
