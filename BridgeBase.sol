// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IBridgeToken is IERC20 {
    function mint(address to, uint256 amount) external;
    function burn(address from, uint256 amount) external;
}

contract BridgeBase is Ownable {
    IBridgeToken public token;
    mapping(bytes32 => bool) public processedNonces;

    event BridgeRequest(address indexed user, uint256 amount, uint256 nonce, uint256 targetChainId);
    event BridgeRelease(address indexed user, uint256 amount, uint256 nonce);

    constructor(address _token) Ownable(msg.sender) {
        token = IBridgeToken(_token);
    }

    function requestBridge(uint256 amount, uint256 nonce, uint256 targetChainId) external {
        token.burn(msg.sender, amount);
        emit BridgeRequest(msg.sender, amount, nonce, targetChainId);
    }

    function releaseTokens(address user, uint256 amount, uint256 nonce, bytes32 txHash) external onlyOwner {
        require(!processedNonces[txHash], "Transfer already processed");
        processedNonces[txHash] = true;
        token.mint(user, amount);
        emit BridgeRelease(user, amount, nonce);
    }
}
