import { ethers } from "hardhat";
const helpers = require("@nomicfoundation/hardhat-network-helpers");

async function main() {
  const [deployer] = await ethers.getSigners()
  console.log(deployer.address, "deployer")
  const ImpersonateAddress = "0x1cfb8a2e4c2e849593882213b2468e369271dad2"
  await helpers.impersonateAccount(ImpersonateAddress);

  const impersonatedSigner = await ethers.getSigner(ImpersonateAddress);

  const myTokenContract = await ethers.getContractFactory("Mine");
  const myContract = await myTokenContract.deploy();

  await myContract.deployed();

  console.log(`Contract Address deployed to: ${myContract.address}`)

  // const StakingContract = await ethers.getContractFactory("Staking");
  // const stakingContract = await StakingContract.deploy();

  // await stakingContract.deployed();

  // console.log(`Contract Address deployed to: ${stakingContract.address}`)

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


// 0xd753c12650c280383Ce873Cc3a898F6f53973d16