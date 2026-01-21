# Cross-Chain Token Bridge

This repository provides a minimalist, secure framework for a cross-chain token bridge. It utilizes the "Burn-and-Mint" pattern, where tokens are locked or burned on the source chain and a corresponding synthetic asset is minted on the destination chain.

### Technical Overview
* **Source Chain:** The bridge contract burns the user's tokens and emits a `BridgeRequest` event.
* **Relayer:** An off-chain service (simulated via `relayer.js`) listens for events and submits proofs to the destination.
* **Destination Chain:** The bridge contract verifies the request and mints the equivalent token amount.

### Security Features
* **Validator Signatures:** Mints require a cryptographic signature from a trusted validator.
* **Nonce Tracking:** Prevents replay attacks across networks.
* **Emergency Pause:** Allows admins to halt bridging in case of network instability.
