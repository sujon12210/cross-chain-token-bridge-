const { ethers } = require("ethers");

async function listenAndRelay(sourceBridge, destBridge, wallet) {
    sourceBridge.on("BridgeRequest", async (user, amount, nonce, targetChainId) => {
        console.log(`Processing bridge for ${user}...`);
        const txHash = ethers.id(nonce.toString());
        await destBridge.connect(wallet).releaseTokens(user, amount, nonce, txHash);
        console.log("Tokens released on destination chain.");
    });
}
