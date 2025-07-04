# 📌 FundMe Smart Contract

A simple crowdfunding smart contract that accepts ETH contributions only if the value sent meets a minimum USD threshold using Chainlink price feeds.

---

## 🧾 Overview

This project demonstrates:

- Accepting ETH from users only if it meets a **minimum USD value** (in this case, $5).
- Using **Chainlink Price Feeds** to convert ETH to USD on-chain.
- Keeping track of contributors and their contribution amounts.
- Allowing only the contract owner to withdraw all funds.
- Demonstrating three Ethereum fund transfer methods: `transfer`, `send`, and `call`.

---

## 🔩 Contracts

### 1. `FundMe.sol`

Handles the main crowdfunding logic:
- Stores funders' addresses and contributed amounts.
- Verifies a minimum USD value before accepting ETH.
- Allows the **owner only** to withdraw ETH.

### 2. `PriceConverter.sol`

A helper library using Chainlink to:
- Get real-time ETH/USD price.
- Convert an ETH amount to its USD equivalent.

---

## 🚀 How It Works

1. When a user calls `fundMe()`:
   - Their ETH amount is converted to USD using the `PriceConverter` library.
   - If the amount is **≥ $5**, it's accepted and recorded.
   - Otherwise, the transaction is reverted.

2. The contract owner can call `withdraw()` to:
   - Reset all funder records.
   - Withdraw all ETH using the `.call()` method.

---

## 🔐 Access Control

- Only the deploying wallet (`i_owner`) can withdraw funds.

---

## ⚙️ Requirements

- Solidity `^0.8.18`
- Chainlink Price Feed: `ETH/USD`  
  (address used: `0x694AA1769357215DE4FAC081bf1f309aDC325306`)
- Chainlink Aggregator Interface

---

## Deploy

- Compile both files
- Deploy `FundMe.sol`
- Make sure your environment is set to:
  - **Injected Provider - Metamask** (for testnet)
  - Or **Remix VM** (for local testing)

> ✅ If using Injected Web3, connect to Sepolia (or any network that supports Chainlink price feeds)

---

## 🔗 Chainlink ETH/USD Feed Used

```solidity
// Sepolia ETH/USD Price Feed
AggregatorV3Interface priceFeed = AggregatorV3Interface(
  0x694AA1769357215DE4FAC081bf1f309aDC325306
);
