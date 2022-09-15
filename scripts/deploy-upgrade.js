// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the

// const { ethers } = require("@nomiclabs/hardhat-ethers");
const { ethers, upgrades } = require("hardhat");
// global scope, and execute the script.

async function main() {
  // We get the contract to deploy
  const Box = await ethers.getContractFactory("Box");
  console.log("Deploying Box...");
  // const box = await Box.deploy();
  const box = await upgrades.deployProxy(Box, [42], { initializer: "store" });
  await box.deployed();
  console.log("ToSBT deployed to:", box.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
