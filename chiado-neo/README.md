# Chiado testnet

Chiado testnet is meant to prepare the staking community of the Gnosis Beacon Chain for the upcoming merge.

- TTD: `TBD`. Projected for Aug 15th ~16h UTC (207360 blocks)
- Conensus layer genesis: `1662717600` Sep 09 2022 10:00:00 GMT+0000, root `TBD`
- Altair fork: epoch 90 (2h after CL genesis)
- Bellatrix fork: epoch 180 (4h after CL genesis)

# How to run a staking validator

All existing guides for running validators in Ethereum merge testnets apply.

## Pre-bundled clients

We have bundled the Chiado genesis and config files into custom docker images so you don't have to worry about importing them. Check repo's below for dockerhub image tags + guides and how configure them

Execution clients

- [gnosischain/nethermind-client](https://github.com/gnosischain/nethermind-client)

Consensus clients

- [gnosischain/lighthouse-client](https://github.com/gnosischain/lighthouse-client)
- [gnosischain/lodestar-client](https://github.com/gnosischain/lodestar-client)
- [gnosischain/prysm-client](https://github.com/gnosischain/prysm-client)
- [gnosischain/teku-client](https://github.com/gnosischain/teku-client)

## DAppNode Packages

Execution clients

- Nethermind ([repo](https://github.com/dappnode/DAppNodePackage-Chiado-Nethermind)) - install link http://my.dappnode/#/installer/%2Fipfs%2FQmZ38eZ2yWUndyUf4xwzDQChMkcN7D55peiR3dfVcvHnnY

Consensus clients

- Lighthouse ([repo](https://github.com/dappnode/DAppNodePackage-lighthouse-chiado)) - install link http://my.dappnode/#/installer/%2Fipfs%2FQmQrCBHhHk2qwNGT1uRmcqj2UNzNXUVJasuj88VVfofRNR
- Teku ([repo](https://github.com/dappnode/DAppNodePackage-teku-chiado)) - install link http://my.dappnode/#/installer/%2Fipfs%2FQmR3vTEzTY8XF7arGgX1kuVDjmsmn4n5cN5cDUhNLPdowP

Web3Signer package to add keys

- Web3Signer ([repo](https://github.com/dappnode/DAppNodePackage-web3signer-chiado)) - install link http://my.dappnode/#/installer/%2Fipfs%2FQmQ3nAB7zKAsjZzf5cN6kg8Xm1upzyQbnFyW8oqLRwUYyE

## Getting staking keys

_TBD_

| Index range   | mnemonic           | first    | hosts, clients                               |
| ------------- | ------------------ | -------- | -------------------------------------------- |
| 00000 - 03000 | chiado_mnemonic_00 | multiply | local - chiado-lighthouse-nethermind-{10:19} |
| 03000 - 06000 | chiado_mnemonic_01 | pilot    | local - chiado-prysm-nethermind-{10:19}      |
| 06000 - 10000 | chiado_mnemonic_02 | arctic   | external - Kleros.io                         |

# Testnet data

```yaml
genesis_time: 1660132800
genesis_state_root: 0x71eb8c2b9d7ad58733bfdd1008e7a35f70303833f1ac308fd53d1b4799f15db7
genesis_validators_count: 70000

eth1_data:
  deposit_root: 0xd70a234731285c6804c2a4f56711ddb8c82c99740f207854891028af34e27e5e
  deposit_count: 0
  block_hash: 0x0000000000000000000000000000000000000000000000000000000000000000
```

All config files available [here](custom_config_data)

Consensus layer files:

- [config.yaml](custom_config_data/config.yaml)
- [genesis.ssz](custom_config_data/genesis.ssz)
- [bootnodes_consensus.txt](custom_config_data/bootnodes_consensus.txt)

Execution layer files:

- [nethermind_genesis.json](custom_config_data/nethermind_genesis.json)
- [bootnodes_execution.txt](custom_config_data/bootnodes_execution.txt)
