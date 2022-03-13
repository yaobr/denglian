
const hre = require("hardhat");
const { writeAddr } = require('./artifact_log.js');

const MyERC20Addr = require(`../deployments/${network.name}/MyERC20.json`)



async function main() {
  const Vault = await hre.ethers.getContractFactory("Vault");
  const vault = await Vault.deploy(MyERC20Addr.address);

  await vault.deployed();

  console.log("Vault deployed to:", vault.address);
  await writeAddr(vault.address, "Vault", network.name)

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
