docker build -t gnosischain/lodestar:latest .
docker push gnosischain/lodestar:latest   

# Starting the container in beacon mode 
```
beacon
--preset=gnosis
--paramsFile=/custom_config_data/config.yaml
--genesisStateFile=/custom_config_data/genesis.ssz
--network.discv5.bootEnrs="{{ bootnode_enrs[0] }}"
```

# Starting the container in validator mode
```
validator
--preset=gnosis
--paramsFile=/custom_config_data/config.yaml
```