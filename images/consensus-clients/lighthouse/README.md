docker build -t gnosischain/lighthouse:latest --build-arg UPSTREAM_VERSION=latest --build-arg BEACON_API_PORT=3500 .
docker push gnosischain/lighthouse:latest   



# Starting the container in beacon mode 
```
lighthouse
--testnet-dir="/custom_config_data"
beacon
--boot-nodes="{{ bootnode_enrs | join(',') }}"
```


# Starting the container in validator mode
```
lighthouse
--testnet-dir="/custom_config_data"
vc
```