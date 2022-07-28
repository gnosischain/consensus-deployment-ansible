docker build -t gnosischain/nethermind:latest --build-arg UPSTREAM_VERSION=latest .
docker push gnosischain/nethermind:latest   

# Starting the container 
```
--config=/networkdata/nethermind_config.cfg
--Init.ChainSpecPath="/networkdata/nethermind_genesis.json"
```
