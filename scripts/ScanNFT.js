// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the

// const { ethers } = require("@nomiclabs/hardhat-ethers");
const fetchNFTs = async () => {
  let nfts;
  console.log("fetching nfts");
  const api_key = "iWurQrdbTIHozBZHMGeth_uQZwFJ8Dmb";
  const baseURL = `https://eth-mainnet.alchemyapi.io/v2/${api_key}/getNFTs/`;
  var requestOptions = {
    method: "GET",
  };

  if (!collection.length) {
    const fetchURL = `${baseURL}?owner=${wallet}`;

    nfts = await fetch(fetchURL, requestOptions).then((data) => data.json());
  } else {
    console.log("fetching nfts for collection owned by address");
    const fetchURL = `${baseURL}?owner=${wallet}&contractAddresses%5B%5D=${collection}`;
    nfts = await fetch(fetchURL, requestOptions).then((data) => data.json());
  }

  if (nfts) {
    console.log("nfts:", nfts);
    setNFTs(nfts.ownedNfts);
  }
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
