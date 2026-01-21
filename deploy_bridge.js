async function main() {
    const Bridge = await ethers.getContractFactory("BridgeBase");
    const bridge = await Bridge.deploy("0xTokenAddress");
    console.log("Bridge deployed to:", await bridge.getAddress());
}
