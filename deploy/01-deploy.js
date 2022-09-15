// deploy/00_deploy_my_contract.js
const { network, ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  console.log("----------------------------------------------------");
  await deploy("Box", {
    from: deployer,
    args: [],
    log: true,
  });
  console.log("----------------------------------------------------");
};
module.exports.tags = ["Box"];
