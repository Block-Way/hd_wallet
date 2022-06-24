# wallet_sdk_flutter

Flutter Native Wallet SDK for Sugar Foundation projects

## Introduction

This Wallet SDK support the following crypto network:

- BTC (Bitcoin)
- BBC (BigBangCore and forks)
- ETH (Ethereum and ERC20 tokens)
- TRX (Tron and TRC20 tokens)

## Getting Started

Add the dependency in your project's 'pubspec.yaml' file.

```yaml

```

## Wallet Core

The wallet core provide the functionality to:

- **generateMnemonic**: Create new mnemonic words
- **validateMnemonic**: Validate mnemonic words
- **validateAddress**: validate a coin address
- **importMnemonic**: Import mnemonics using `Bip44` or `Bip39` with custom path
- **signTx**: Sign a raw transaction with the given mnemonic
- **signMsg**: Sign a text message with the given mnemonic
- **signMsgWithPKAndBlake**: Sign a text message with the given privateKey using `Blake2b256`
