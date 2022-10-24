const { network, ethers } = require("hardhat");
const { contractAddressMumbai } = require("../constants");
const {
  contractAddressMumbaiFile,
  coinAbiFile,
} = require("../helper-hardhat-config");
const fs = require("fs");

async function updateCoinAddress() {
  const coin = await ethers.getContract("Coin");

  const contractAddress = JSON.parse(
    fs.readFileSync(contractAddressMumbaiFile, "utf-8")
  );
  contractAddress.coin = coin.address;

  fs.writeFileSync(contractAddressMumbaiFile, JSON.stringify(contractAddress));

  fs.writeFileSync(
    coinAbiFile,
    coin.interface.format(ethers.utils.FormatTypes.json)
  );
}

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  //   const addr = JSON.parse(fs.readFileSync(contractAddresses, "utf8"));
  //   const addr = JSON.stringify(contractAddresses);
  // const chainId = network.config.chainId;
  //   console.log(chainId);
  //   const addr = JSON.parse(contractAddresses);
  console.log(contractAddressMumbai.character);
  console.log("Deploying Coin");
  console.log("----------------------------------------------------");
  await deploy("Coin", {
    contract: "contracts/core/Coin.sol:Coin",
    from: deployer,
    args: [contractAddressMumbai.character],
    log: true,
  });
  console.log("----------------------------------------------------");
  await updateCoinAddress();
};
module.exports.tags = ["Coin"];
