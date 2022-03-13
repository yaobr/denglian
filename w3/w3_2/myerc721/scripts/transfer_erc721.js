const { ethers, network } = require("hardhat");

const ERC721Addr = require(`../deployments/${network.name}/MyERC721.json`)

async function main() {
    let tokenid= 4444;
    let [owner, second] = await ethers.getSigners();

    let myerc721 = await ethers.getContractAt("MyERC721",
        ERC721Addr.address,
        owner);

    await myerc721.mint(owner.address, tokenid);
    await myerc721.transfer(owner.address, second.address, tokenid);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });


  // duration = 60;
  // await delay.advanceTime(ethers.provider, duration); 
  // await delay.advanceBlock(ethers.provider);