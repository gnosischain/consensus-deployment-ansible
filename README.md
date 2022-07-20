# Testnet ansible files + Config

This repository is a minimal set of playbooks and inventories required to set up the merge devnets consisting of execution and
consensus nodes.

## General information

- General folder structure: All testnet relevant configs are under the testnet names. Generic config variables are set under
  `<name>-testnet/inventory/group_vars/all.yaml`. Client specific variables are set under e.g `<name>-testnet/inventory/group_vars/eth2client_xxxxxx.yaml`.
  The client specific variables also contains the commands used to start the docker image with.
- All the config files, `genesis.ssz` and other variables needed for the testnet are placed under `<name>-testnet/custom_config_data`.

## Instructions to join testnet

1. Clone this repository
2. Ensure `docker` and `docker-compose` is installed: `docker-compose --version` and `docker --version`
3. Change directories with `cd consensus-deployment-ansible/scripts/quick-run/<testnet-type>`
4. Create the required directories for persistent data with `mkdir -p execution_data beacon_data`
5. Find your IP address(public IP) and add it to the `<testnet-name>.vars` file file located in `consensus-deployment-ansible/scripts/quick-run/`, this is just to ensure easy peering  
   5.1 `curl ifconfig.me` or visit https://whatismyipaddress.com  
   5.2 Replace IP in config file with your own IP address: https://i.imgur.com/xnNqN6h.png
6. Run your chosen execution engine, e.g: `docker-compose --env-file <testnet-name>.vars -f docker-compose.geth.yml up -d`
7. Run your chosen consensus engine, e.g: `docker-compose --env-file <testnet-name>.vars -f docker-compose.lighthouse.yml up -d`
8. Check your logs to confirm that they are up and syncing, e.g `docker logs lighthouse_beacon -f --tail=20`
9. To stop the clients, run `docker-compose -f <insert file name you used earlier here> down`

## Alternative Instructions to join the Kintsugi testnet

- [ethstaker instructions to join Kintsugi](https://github.com/remyroy/ethstaker/blob/main/merge-devnet.md)

## Instructions for running ansible playbooks (Only works if you have access)

1. Clone this repository
2. Ensure `ansible` is installed
3. Make changes in the required variable, e.g: Change the `pithos-testnet/inventory/group_vars/eth1client_ethereumjs.yaml`
   with the new docker image or the `eth1_start_args` for commands to run the container with
4. The `update_execution_beacon_and_validator.yml` will stop the execution, beacon and validator containers and restart them
   with the new configurations specified as variables. Please use the `limit=eth1/2_xxxx` flag to limit the playbook execution to just update
   the nodes you have access to (otherwise it won't change the config on the others, but will show a lot of errors).
   Run this playbook with: `ansible-playbook -i pithos-testnet/inventory/inventory.ini playbooks/update_execution_beacon_and_validator.yml --limit=eth1client_ethereumjs`
5. If you just want to update an execution node without touching the other docker containers use the `tasks`, e.g to restart execution node with the new parameters use,

```bash
ansible-playbook -i pithos-testnet/inventory/inventory.ini playbooks/tasks/stop_execution_node.yml --limit=eth1client_ethereumjs
ansible-playbook -i pithos-testnet/inventory/inventory.ini playbooks/tasks/start_execution_node.yml --limit=eth1client_ethereumjs
```

## Use docker logs with custom logging drivers

By default the docker daemon collects logs using the `json-file` driver. While this is useful for most of the cases, there could be some specific scenarios where another logging driver should be used.

If so, just specify the variables `common_log_driver` and `common_log_options` in the all.yml config file (it will use `json-file` by default).

Accepted values are the ones from the official docker [documentation](https://docs.docker.com/config/containers/logging/)

Please note that if you are changing the logging driver of an already running container, there might need for a restart of the container in order to have docker get the latest config changes.

#### User docker logs with fluentd

There's a ready-to-use playbook which takes care of installing the fluentd logs collector.
Just set the following variables in `all.yml` or on your `secrets.yml` file:
- `logging_host=URL To Logs Collector`
- `logging_auth_user=User With Permissions to push logs`
- `logging_auth_password=User Password`

Sample logging driver configurations:
```
## JSON file
common_log_driver: json-file
common_log_options:
  max-file: "10"
  max-size: 500m
  mode: non-blocking
  max-buffer-size: 4m

## Fluentd

common_log_driver: fluentd
common_log_options: {}
```

That can be either an ElasticSearch or OpenSearch URL.

## Instructions to deploy testnet

**1. Provision**

Provision instances and allocate hosts in `$testnet/inventory/inventory.ini`

```ini
$network-$eth2client-$eth1client-1 ansible_host=159.223.195.87 mnemonic={{mnemonic_0}} indexes=2000..3000
```

Create a mnemonic with https://iancoleman.io/bip39/ and set it in a hidden `secrets.yml`, for example:

```yaml
mnemonic_0: "giant issue aisle success illegal bike spike question tent bar rely arctic volcano long crawl hungry vocal artwork sniff fantasy very lucky have athlete"
```

**2. Deploy**

> **Note**:
By default the docker daemon collects logs using the `json-file` driver, check this section out if you want to ship logs using a custom provider: `Use docker logs with custom logging drivers`.

Execute the following playbooks only if you want to make Dockerd collect logs using a custom logging driver, e.g. fluentd (make sure to check-out the requirements in `Use docker logs with custom logging drivers`).
```
ansible-playbook -i $network/inventory/inventory.ini playbooks/setup_logging_capability.yml
```

> **Note**: AuRa does not handle well starting with multiple validating nodes. Set a single `mining_keyi=0` on first deployment. Then after some blocks (enough to sync), edit inventory to add more validating nodes and re-deploy execution.

Deploy everything from scratch

```
ansible-playbook -i $network/inventory/inventory.ini playbooks/deploy_devnet_from_scratch.yml
```

**3. Set bootnodes**

Grab execution node's endoes with command below and paste some of them into `$network/inventory/group_vars/all.yaml` to act as bootnodes in variable `eth1_bootnode_enode`

```
ansible-playbook -i $network/inventory/inventory.ini playbooks/tasks/collect_enodes.yml
```

Grab beacon node's ENRs with command below and paste some of them into `$network/inventory/group_vars/all.yaml` to act as bootnodes in variable `bootnode_enrs`

```
ansible-playbook -i $network/inventory/inventory.ini playbooks/tasks/collect_enrs.yml
```

Then re-deploy execution and beacon nodes to connect them

```
ansible-playbook -i $network/inventory/inventory.ini playbooks/tasks/start_beacon.yml
ansible-playbook -i $network/inventory/inventory.ini playbooks/tasks/start_execution_node.yml
```

- **6. Extra tooling**

* Deploy eth1 explorer
* Deploy eth2 explorer
* Deploy ethstats
* Deploy faucet
* Deploy landing page
