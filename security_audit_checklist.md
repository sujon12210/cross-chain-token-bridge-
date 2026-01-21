1. Check for Reentrancy on `releaseTokens`.
2. Ensure only the `BRIDGE_ROLE` can call mint/burn.
3. Verify nonce uniqueness to prevent double-spending.
4. Validate that `targetChainId` matches the destination network.
