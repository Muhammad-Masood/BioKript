import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-ethers";
import "@nomicfoundation/hardhat-chai-matchers"
import "dotenv/config";

const priv_key = process.env.private_key;

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  defaultNetwork: "bscTestnet",
  networks:{
    bscTestnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      chainId: 97,
      accounts: [priv_key as string],
  }
},
}

export default config;
