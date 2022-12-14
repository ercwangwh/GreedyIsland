const { network, ethers } = require("hardhat");
const { contractAddresses, contractAddressMumbai } = require("../constants");
const {
  contractAddressMumbaiFile,
  stakingFile,
} = require("../helper-hardhat-config");
const fs = require("fs");

async function updateStakingAddress() {
  const staking = await ethers.getContract("Staking");

  const contractAddress = JSON.parse(
    fs.readFileSync(contractAddressMumbaiFile, "utf-8")
  );
  contractAddress.staking = staking.address;

  fs.writeFileSync(contractAddressMumbaiFile, JSON.stringify(contractAddress));

  fs.writeFileSync(
    stakingFile,
    staking.interface.format(ethers.utils.FormatTypes.json)
  );
}

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  //   const addr = JSON.parse(fs.readFileSync(contractAddresses, "utf8"));
  //   const addr = JSON.stringify(contractAddresses);
  const chainId = network.config.chainId;
  //   console.log(chainId);
  //   const addr = JSON.parse(contractAddresses);
  console.log(contractAddressMumbai.knight);
  console.log("Deploying Staking");
  console.log("----------------------------------------------------");
  await deploy("Staking", {
    contract: "contracts/core/Staking.sol:Staking",
    from: deployer,
    args: [
      contractAddressMumbai.knight,
      contractAddressMumbai.coin,
      contractAddressMumbai.character,
    ],
    log: true,
  });
  console.log("----------------------------------------------------");
  await updateStakingAddress();
};
module.exports.tags = ["Staking"];
