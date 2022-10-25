import {execSync} from "node:child_process";

// Usage
// ```
// node ttd.mjs "Oct 29 2022 14:00:00 GMT+0000" latest https://rpc.eu-central-2.gateway.fm/v3/gnosis/archival/chiado
// ```

const ttdTargetDateStr = process.argv[2];
const blockNumberReference = process.argv[3] ?? "latest";
const rpcUrl = process.argv[4] ?? "https://rpc.gnosischain.com/";
const secondsPerBlock = 5; // Edit in networks with missed blocks

const ttdTargetDate = new Date(ttdTargetDateStr);
if (isNaN(ttdTargetDate)) throw Error(`Invalid date ${ttdTargetDateStr}, use format 'Oct 29 2022 12:00:00 GMT+0000'`);

// number: '0x1786dd7'
// timestamp: '0x63514d94',
// totalDifficulty: '0x1786dd6ffffffffffffffffffffffffeaac82a5',
const {totalDifficulty, timestamp, number} = fetchBlock(blockNumberReference);

const secondsToTTD = Math.round(ttdTargetDate.getTime() / 1000) - parseInt(timestamp);
const blocksToTTD = Math.round(secondsToTTD / secondsPerBlock);
const difficultyToTTD = BigInt(blocksToTTD) * BigInt("0xfffffffffffffffffffffffffffffffe");
const TTD = BigInt(totalDifficulty) + difficultyToTTD;
const TTDBlockNum = parseInt(number) + blocksToTTD;

console.log(`
TTD   ${TTD}
block ${TTDBlockNum}
time  ${ttdTargetDate.toISOString()}
sec/b ${secondsPerBlock}
Ref block ${parseInt(number)} from ${rpcUrl}
`);

function fetchBlock(blockRef) {
  const txt = execSync(`curl -s -X POST --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["${blockRef}"],"id":0}' ${rpcUrl}`, {encoding: "utf8"});
  const json = JSON.parse(txt);
  if (!json.result) throw Error(txt);
  return json.result;
}