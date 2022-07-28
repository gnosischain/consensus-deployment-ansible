docker build -t gnosischain/prysm:latest --build-arg UPSTREAM_VERSION=v2.1.2 .
docker push gnosischain/prysm:latest   

# Starting the container in beacon mode 
```
--chain-config-file="/custom_config_data/config.yaml"
--genesis-state="/custom_config_data/genesis.ssz"
--bootstrap-node="{{ bootnode_enrs[0] }}"
--bootstrap-node="{{ bootnode_enrs[1] }}"
```

# Starting the container in validator mode
```
--chain-config-file="/custom_config_data/config.yaml"
```