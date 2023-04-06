async function main() {
	const ERC5516Factory = await ethers.getContractFactory('ERC5516');
	const ERC5516 = await ERC5516Factory.deploy();
	await ERC5516.deployed();
	console.log('ERC5516 deployed to:', ERC5516.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
	console.error(error);
	process.exitCode = 1;
});
