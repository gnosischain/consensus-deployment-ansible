#!/bin/bash

NETWORK_DIR=$1

# Tool to validate
# $network_name/custom_config_data/genesis.ssz

docker run --rm --network host \
-v $PWD/$NETWORK_DIR/custom_config_data:/data \
sigp/lighthouse lighthouse --testnet-dir="/data" beacon_node \
  --http --http-address=0.0.0.0 --http-port=4000