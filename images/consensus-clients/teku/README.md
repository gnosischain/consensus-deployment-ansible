docker build -t gnosischain/teku:latest --build-arg UPSTREAM_VERSION=latest --build-arg BEACON_API_PORT=3500 .
docker push gnosischain/teku:latest   

# Starting the container in beacon mode 
```
--network="/custom_config_data/config.yaml"
--initial-state="/custom_config_data/genesis.ssz"
--p2p-discovery-bootnodes="{{ bootnode_enrs | join(',') }}"

```

# Starting the container in validator mode
```
--network="/custom_config_data/config.yaml"

```