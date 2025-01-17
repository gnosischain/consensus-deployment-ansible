#!/bin/bash

DATA_DIR=$PWD/bad_state_data

mkdir -p $DATA_DIR

cat <<EOT > $DATA_DIR/mnemonics.yaml
- count: 8000
  mnemonic:
    nurse small net shrug resource equip trigger turkey april reunion taxi
    detect easy anxiety stone pulp knee sunny boost coral security apart mobile come
EOT

cat <<EOT > $DATA_DIR/config.yaml
# Extends the mainnet preset
PRESET_BASE: "gnosis"
# needs to exist because of Prysm. Otherwise it conflicts with mainnet genesis
CONFIG_NAME: "gc-merge-devnet-3"

# Genesis
# If 14000 = oK
# If 8000 = error "Error: Offset data length not multiple of 4"
MIN_GENESIS_ACTIVE_VALIDATOR_COUNT: 8000
# Jul 19 2022 20:00:00 GMT+0000
MIN_GENESIS_TIME: 1658260800
GENESIS_DELAY: 300

TERMINAL_TOTAL_DIFFICULTY: 735009912549227081080889152052619336740640

# Deposit contract
# ---------------------------------------------------------------
# NOTE: Don't use a value too high, or Teku rejects it (4294906129 NOK)
DEPOSIT_CHAIN_ID: 100993
DEPOSIT_NETWORK_ID: 100993
DEPOSIT_CONTRACT_ADDRESS: "0x4242424242424242424242424242424242424242"

# Misc
# ---------------------------------------------------------------
# 2**6 (= 64)
MAX_COMMITTEES_PER_SLOT: 64
# 2**7 (= 128)
TARGET_COMMITTEE_SIZE: 128
# 2**11 (= 2,048)
MAX_VALIDATORS_PER_COMMITTEE: 2048
# 2**2 (= 4)
MIN_PER_EPOCH_CHURN_LIMIT: 4
# 2**12 (= 4096)
CHURN_LIMIT_QUOTIENT: 4096
# See issue 563
SHUFFLE_ROUND_COUNT: 90
# 4
HYSTERESIS_QUOTIENT: 4
# 1 (minus 0.25)
HYSTERESIS_DOWNWARD_MULTIPLIER: 1
# 5 (plus 1.25)
HYSTERESIS_UPWARD_MULTIPLIER: 5
# Fork Choice
# ---------------------------------------------------------------
# 2**3 (= 8)
SAFE_SLOTS_TO_UPDATE_JUSTIFIED: 8
# Validator
# ---------------------------------------------------------------
# 2**10 (= 1024) ~1.4 hour
ETH1_FOLLOW_DISTANCE: 1024
# 2**4 (= 16)
TARGET_AGGREGATORS_PER_COMMITTEE: 16
# 2**0 (= 1)
RANDOM_SUBNETS_PER_VALIDATOR: 1
# 2**8 (= 256)
EPOCHS_PER_RANDOM_SUBNET_SUBSCRIPTION: 256
# 6 (estimate from xDai mainnet)
SECONDS_PER_ETH1_BLOCK: 6

# Gwei values
# ---------------------------------------------------------------
# 2**0 * 10**9 (= 1,000,000,000) Gwei
MIN_DEPOSIT_AMOUNT: 1000000000
# 2**5 * 10**9 (= 32,000,000,000) Gwei
MAX_EFFECTIVE_BALANCE: 32000000000
# 2**4 * 10**9 (= 16,000,000,000) Gwei
EJECTION_BALANCE: 16000000000
# 2**0 * 10**9 (= 1,000,000,000) Gwei
EFFECTIVE_BALANCE_INCREMENT: 1000000000
# Initial values
# ---------------------------------------------------------------
# GBC area code
GENESIS_FORK_VERSION: 0x13001029
BLS_WITHDRAWAL_PREFIX: 0x00
# Time parameters
# ---------------------------------------------------------------
# 5 seconds
SECONDS_PER_SLOT: 5
# 2**0 (= 1) slots 12 seconds
MIN_ATTESTATION_INCLUSION_DELAY: 1
# 2**4 (= 16) slots 1.87 minutes
SLOTS_PER_EPOCH: 16
# 2**0 (= 1) epochs 1.87 minutes
MIN_SEED_LOOKAHEAD: 1
# 2**2 (= 4) epochs 7.47 minutes
MAX_SEED_LOOKAHEAD: 4
# 2**6 (= 64) epochs ~2 hours
EPOCHS_PER_ETH1_VOTING_PERIOD: 64
# 2**13 (= 8,192) slots ~15.9 hours
SLOTS_PER_HISTORICAL_ROOT: 8192
# 2**8 (= 256) epochs ~8 hours
MIN_VALIDATOR_WITHDRAWABILITY_DELAY: 256
# 2**8 (= 256) epochs ~8 hours
SHARD_COMMITTEE_PERIOD: 256
# 2**2 (= 4) epochs 7.47 minutes
MIN_EPOCHS_TO_INACTIVITY_PENALTY: 4

# State vector lengths
# ---------------------------------------------------------------
# 2**16 (= 65,536) epochs ~85 days
EPOCHS_PER_HISTORICAL_VECTOR: 65536
# 2**13 (= 8,192) epochs ~10.6 days
EPOCHS_PER_SLASHINGS_VECTOR: 8192
# 2**24 (= 16,777,216) historical roots, ~15,243 years
HISTORICAL_ROOTS_LIMIT: 16777216
# 2**40 (= 1,099,511,627,776) validator spots
VALIDATOR_REGISTRY_LIMIT: 1099511627776
# Reward and penalty quotients
# ---------------------------------------------------------------
# 25
BASE_REWARD_FACTOR: 25
# 2**9 (= 512)
WHISTLEBLOWER_REWARD_QUOTIENT: 512
# 2**3 (= 8)
PROPOSER_REWARD_QUOTIENT: 8
# 2**26 (= 67,108,864)
INACTIVITY_PENALTY_QUOTIENT: 67108864
# 2**7 (= 128) (lower safety margin at Phase 0 genesis)
MIN_SLASHING_PENALTY_QUOTIENT: 128
# 1 (lower safety margin at Phase 0 genesis)
PROPORTIONAL_SLASHING_MULTIPLIER: 1
# Max operations per block
# ---------------------------------------------------------------
# 2**4 (= 16)
MAX_PROPOSER_SLASHINGS: 16
# 2**1 (= 2)
MAX_ATTESTER_SLASHINGS: 2
# 2**7 (= 128)
MAX_ATTESTATIONS: 128
# 2**4 (= 16)
MAX_DEPOSITS: 16
# 2**4 (= 16)
MAX_VOLUNTARY_EXITS: 16
# Signature domains
# ---------------------------------------------------------------
DOMAIN_BEACON_PROPOSER: 0x00000000
DOMAIN_BEACON_ATTESTER: 0x01000000
DOMAIN_RANDAO: 0x02000000
DOMAIN_DEPOSIT: 0x03000000
DOMAIN_VOLUNTARY_EXIT: 0x04000000
DOMAIN_SELECTION_PROOF: 0x05000000
DOMAIN_AGGREGATE_AND_PROOF: 0x06000000
DOMAIN_SYNC_COMMITTEE: 0x07000000
DOMAIN_SYNC_COMMITTEE_SELECTION_PROOF: 0x08000000
DOMAIN_CONTRIBUTION_AND_PROOF: 0x09000000

ALTAIR_FORK_VERSION: 0x21001029
ALTAIR_FORK_EPOCH: 1

BELLATRIX_FORK_VERSION: 0x22001029
BELLATRIX_FORK_EPOCH: 2

INACTIVITY_SCORE_BIAS: 4
# 2**4 (= 16)
INACTIVITY_SCORE_RECOVERY_RATE: 16
INACTIVITY_PENALTY_QUOTIENT_ALTAIR: 50331648
MIN_SLASHING_PENALTY_QUOTIENT_ALTAIR: 64
PROPORTIONAL_SLASHING_MULTIPLIER_ALTAIR: 2

# Sync committee
# ---------------------------------------------------------------
# 2**9 (= 512)
SYNC_COMMITTEE_SIZE: 512
# 2**9 (= 512)
# assert EPOCHS_PER_SYNC_COMMITTEE_PERIOD * SLOTS_PER_EPOCH <= SLOTS_PER_HISTORICAL_ROOT
EPOCHS_PER_SYNC_COMMITTEE_PERIOD: 512
EOT

# Lighthouse needs this file
echo "0" > $DATA_DIR/deploy_block.txt

docker run --entrypoint=eth2-testnet-genesis \
-v $DATA_DIR:/data \
skylenet/ethereum-genesis-generator phase0 \
--eth1-block 0x0000000000000000000000000000000000000000000000000000000000000000 \
--timestamp 1658260800 \
--config /data/config.yaml \
--mnemonics /data/mnemonics.yaml \
--tranches-dir /data/tranches \
--state-output /data/genesis.ssz

docker run \
-v $DATA_DIR:/data \
sigp/lighthouse lighthouse --testnet-dir="/data" beacon_node