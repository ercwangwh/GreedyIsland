// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the

// const { ethers } = require("@nomiclabs/hardhat-ethers");
const {ethers} = require("hardhat");
// global scope, and execute the script.

async function main () {
  // We get the contract to deploy
  const ToSBT = await ethers.getContractFactory('ToSBT');
  console.log('Deploying ToSBT...');
  const toSBT = await ToSBT.deploy();
  await toSBT.deployed();
  console.log('ToSBT deployed to:', toSBT.address);
}


main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });