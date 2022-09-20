// deploy/00_deploy_my_contract.js
const { network, ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  console.log("Deploying Codex");
  console.log("----------------------------------------------------");
  await deploy("CodexEvents", {
    contract: "contracts/codex/CodexEvents.sol:CodexEvents",
    from: deployer,
    args: [],
    log: true,
  });
  console.log("----------------------------------------------------");

  console.log("Deploying Core");
  console.log("----------------------------------------------------");
  await deploy("Character", {
    contract: "contracts/core/Character.sol:Character",
    from: deployer,
    args: [],
    log: true,
  });

  await deploy("Events", {
    contract: "contracts/core/Events.sol:Events",
    from: deployer,
    args: [],
    log: true,
  });

  console.log("----------------------------------------------------");
};
module.exports.tags = ["Deploy"];
