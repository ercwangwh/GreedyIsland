const { expect } = require("chai");
const { ethers, deployments } = require("hardhat");

describe("Charcter", function() {
  let character, characterContract, player, deployer;

  beforeEach(async () => {
    accounts = await ethers.getSigners(); // could also do with getNamedAccounts
    deployer = accounts[0];
    player = accounts[1];
    await deployments.fixture(["Deploy"]); // Deploys modules with the tags
    characterContract = await ethers.getContract("Character"); // Returns a new connection to the Raffle contract
    character = characterContract.connect(player); // Returns a new instance of the Raffle contract connected to player
  });

  it("Should mint character successfully", async () => {
    console.log(deployer.address);
    console.log(player.address);
    await character.summon();
    const info = await character.hunter_info(0);
    // console.log(info._name);
    // expect(info._name).to.equal(player.address);
    expect(info._level).to.equal(1);
    expect(info._xp).to.equal(0);
    // expect(info._name.to.equal(player.address));
  });
});
