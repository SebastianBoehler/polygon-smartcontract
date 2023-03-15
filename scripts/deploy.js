// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const ONE_HOUR_IN_SECS = 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_HOUR_IN_SECS;

  const maticAmount = '0.05'
  const lockedAmount = hre.ethers.utils.parseEther(maticAmount);

  const AdvancedLock = await hre.ethers.getContractFactory("AdvancedLock");
  const advancedlock = await AdvancedLock.deploy(unlockTime, { value: lockedAmount });

  await advancedlock.deployed();

  console.log(
    `Lock with ${maticAmount} Matic and unlock timestamp ${unlockTime} deployed to ${advancedlock.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
