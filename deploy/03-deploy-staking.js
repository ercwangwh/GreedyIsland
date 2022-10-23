const { network, ethers } = require("hardhat");
const { contractAddresses } = require("../constants");
const fs = require("fs");

module.exports = async ({ getNamedAccounts, deployments }) => {
  //   const { deploy } = deployments;
  //   const { deployer } = await getNamedAccounts();
  //   //   const addr = JSON.parse(fs.readFileSync(contractAddresses, "utf8"));
  //   //   const addr = JSON.stringify(contractAddresses);
  //   const chainId = network.config.chainId;
  //   //   console.log(chainId);
  //   //   const addr = JSON.parse(contractAddresses);
  //   console.log(contractAddresses[chainId].knight);
  //   console.log("Deploying Staking");
  //   console.log("----------------------------------------------------");
  //   await deploy("Staking", {
  //     contract: "contracts/core/Staking.sol:Staking",
  //     from: deployer,
  //     args: [
  //       contractAddresses[chainId].knight,
  //       contractAddresses[chainId].coin,
  //       contractAddresses[chainId].character,
  //     ],
  //     log: true,
  //   });
  //   console.log("----------------------------------------------------");
};
module.exports.tags = ["Deploy"];
