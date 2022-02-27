const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Counter", function () {
  it("Should counter equal 1", async function () {
    const Counter = await ethers.getContractFactory("Counter");
    const counter = await Counter.deploy();
    await counter.deployed();

    await counter.count();
    expect(await counter.getCounter()).to.equal(1);
  });
});
