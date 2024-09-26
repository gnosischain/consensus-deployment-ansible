import child_process from "child_process";
import fs from "fs";

const url = "https://rpc.gnosischain.com/";
const outFile = "xdai_ttd_diff.csv";

switch (process.argv[2]) {
  case "write":
    writeCsv();
    break;
  case "parse":
    parseCsv();
    break;
  default:
    throw Error("Unknown cmd");
}

function writeCsv() {
  let prevBlock = getBlocks(["latest"])[0];
  const fromNum = prevBlock.number;

  const batchSize = 100;

  for (let n = fromNum; n > 0; n -= 10) {
    const nums = [];
    for (let i = n; i > n - batchSize; i--) nums.push(i);

    let blocks = getBlocks(nums);
    blocks = blocks.sort((a, b) => b.number - a.number);

    for (const block of getBlocks(nums)) {
      const tdDiff = prevBlock.totalDifficulty - block.totalDifficulty;
      const row = [block.number, block.totalDifficulty, tdDiff].join(",");

      console.log(row);
      fs.appendFileSync(outFile, row + "\n");

      prevBlock = block;
    }
  }
}

function parseCsv() {
  const csvStr = fs.readFileSync(outFile, "utf8");

  const tdDiffCount = new Map();

  for (const row of csvStr.trim().split("\n")) {
    const [num, td, tdDiff] = row.split(",");
    tdDiffCount.set(tdDiff, 1 + (tdDiffCount.get(tdDiff) ?? 0));
  }

  console.log(tdDiffCount);
}

/**
 * @param {(string|number)[]} nums "latest" | 1234
 * @returns
 */
function getBlocks(nums) {
  const data = nums.map((num, i) => ({
    jsonrpc: "2.0",
    method: "eth_getBlockByNumber",
    params: [num],
    id: i,
  }));

  const resStr = child_process.execSync(
    `curl -X POST --data '${JSON.stringify(data)}' ${url}`,
    { encoding: "UTF-8" }
  );

  const resArr = JSON.parse(resStr);

  return resArr.map((res) => ({
    totalDifficulty: BigInt(res.result.totalDifficulty),
    number: parseInt(res.result.number),
  }));
}
