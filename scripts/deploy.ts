import { ethers } from "hardhat";

async function main() {
  const Biokript = await ethers.getContractFactory('BioKript');
  const BKPT = await Biokript.deploy();
  await BKPT.deployed();
  console.log(`Deployed contract at address ${await BKPT.getAddress()}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
