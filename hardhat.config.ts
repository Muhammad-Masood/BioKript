import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-ethers";
import "@nomicfoundation/hardhat-chai-matchers"
import "@openzeppelin/contracts"
const config: HardhatUserConfig = {
  solidity: "0.8.18",
};

export default config;
