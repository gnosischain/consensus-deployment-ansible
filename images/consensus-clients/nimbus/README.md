docker build -t gnosischain/nimbus:latest --build-arg UPSTREAM_VERSION=v2.2.2 .
docker push gnosischain/nimbus:latest   

# Starting the container in beacon mode 
```
--network="/custom_config_data"
--bootstrap-node="{{ bootnode_enrs | join(',') }}"
```

# Starting the container in validator mode
```
nimbus runs in both modes automatically 
```