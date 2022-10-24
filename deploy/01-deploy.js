// deploy/00_deploy_my_contract.js
const { network, ethers } = require("hardhat");
const { contractAddressMumbai } = require("../constants");
const {
  contractAddressMumbaiFile,
  characterAbiFile,
} = require("../helper-hardhat-config");
const fs = require("fs");

async function updateCharacterAddress() {
  const hunter = await ethers.getContract("Character");

  const contractAddress = JSON.parse(
    fs.readFileSync(contractAddressMumbaiFile, "utf-8")
  );
  contractAddress.character = hunter.address;

  fs.writeFileSync(contractAddressMumbaiFile, JSON.stringify(contractAddress));

  // const hunter = await ethers.getContract("Character");
  // const knight = await ethers.getContract("Knight");
  // const coin = await ethers.getContract("Coin");
  fs.writeFileSync(
    characterAbiFile,
    hunter.interface.format(ethers.utils.FormatTypes.json)
  );
}

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  console.log("Deploying Core");
  console.log("----------------------------------------------------");
  await deploy("Character", {
    contract: "contracts/core/Character.sol:Character",
    from: deployer,
    args: [],
    log: true,
  });

  await updateCharacterAddress();
  console.log("----------------------------------------------------");

  // await deploy("Coin", {
  //   contract: "contracts/core/Coin.sol:Coin",
  //   from: deployer,
  //   args: [],
  //   log: true,
  // });

  // await deploy("Staking", {
  //   contract: "contracts/core/Staking.sol:Staking",
  //   from: deployer,
  //   args: [],
  //   log: true,
  // });

  /*FINISH*/
  // await deploy("Knight", {
  //   contract: "contracts/core/Knight.sol:Knight",
  //   from: deployer,
  //   args: [],
  //   log: true,
  // });
  // console.log("----------------------------------------------------");
};

module.exports.tags = ["Character"];
