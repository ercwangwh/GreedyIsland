const {
  contractsFile,
  characterAbiFile,
  knightAbiFile,
} = require("../helper-hardhat-config");
const fs = require("fs");
const { network, ethers } = require("hardhat");

module.exports = async () => {
  if (process.env.UPDATE_FRONT_END) {
    console.log("Writing to front end...");
    // await updateContractAddresses();
    await updateAbi();
    console.log("Front end written!");
  }
};

async function updateAbi() {
  // const hunter = await ethers.getContract("Character");
  const knight = await ethers.getContract("Knight");
  // fs.writeFileSync(
  //   characterAbiFile,
  //   hunter.interface.format(ethers.utils.FormatTypes.json)
  // );
  fs.writeFileSync(
    knightAbiFile,
    knight.interface.format(ethers.utils.FormatTypes.json)
  );
}

async function updateContractAddresses() {
  const hunter = await ethers.getContract("Character");
  const coin = await ethers.getContract("Coin");
  const knight = await ethers.getContract("Knight");
  const contractAddresses = {
    character: hunter.address,
    coin: coin.address,
    knight: knight.address,
  };
  const contractList = JSON.parse(fs.readFileSync(contractsFile, "utf8"));
  //   if (network.config.chainId.toString() in contractList) {
  //     //     if (
  //     //       !contractList[network.config.chainId.toString()].includes(
  //     //         contractAddresses
  //     //       )
  //     //     ) {
  //     //       //   contractAddresses[network.config.chainId.toString()].push([
  //     //       //     hunter.address,
  //     //       //   ]);
  //     //       contractList[network.config.chainId.toString()].push(hunter.address);
  //     //     }
  //   } else {
  contractList[network.config.chainId.toString()] = contractAddresses;
  // const contractList = {(network.config.chainId.toString()):contractAddresses}
  //   }
  fs.writeFileSync(contractsFile, JSON.stringify(contractList));
}
module.exports.tags = ["all"];
