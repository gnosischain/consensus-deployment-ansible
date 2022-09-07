#!/bin/bash

# Note: Must add --timestamp 9999999
# Matching the one in chiado/custom_config_data/config.yaml

docker run --entrypoint=eth2-testnet-genesis \
-v $PWD/chiado/custom_config_data:/data \
skylenet/ethereum-genesis-generator phase0 \
--eth1-block "0xc293f148710642320209fa0f2d630ee54df5468b1eff25e972a468271157510e" \
--timestamp 1660132800 \
--config /data/config.yaml \
--mnemonics /data/mnemonics.yaml \
--tranches-dir /data/tranches \
--state-output /data/genesis.ssz