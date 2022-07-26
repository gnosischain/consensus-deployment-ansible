#!/bin/bash

# URL=http://localhost:8545
URL=https://rpc.gnosischain.com/

LATEST_BLOCK=$(curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest"],"id":0}' $URL)

# "0x164636c"
LATEST_NUM=$(( $(echo $LATEST_BLOCK | jq '.result.number' | tr -d '"') ))
LATEST_TD_HEX=$(echo $LATEST_BLOCK | jq '.result.totalDifficulty' | tr -d '"')

echo "LATEST NUM $LATEST_NUM TD $LATEST_TD_HEX"

for ((i=LATEST_NUM; i>=1; i--)); do
  echo $i
  BLOCK=$(curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByNumber\",\"params\":[$i],\"id\":0}" $URL)

  TD_HEX=$(echo $BLOCK | jq '.result.totalDifficulty' | tr -d '"')
  TD_DIFF=$(( $LATEST_TD_HEX - $TD_HEX ))

  LATEST_TD_HEX=$TD_DIFF

  echo NUM $i TD $TD TD_HEX $TD_HEX TD_DIFF $TD_DIFF
  
done


