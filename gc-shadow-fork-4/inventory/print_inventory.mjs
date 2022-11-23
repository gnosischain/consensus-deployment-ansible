import { execSync } from "node:child_process";

const tag = "gc-shadow-fork-4";
const indexOffset = 72000;

// gc-shadow-fork-4-lodestar-nethermind-2      159.65.48.13
// gc-shadow-fork-4-lodestar-nethermind-1      146.190.94.227
// gc-shadow-fork-4-lodestar-nethermind-0      137.184.106.157
// gc-shadow-fork-4-teku-nethermind-9          64.227.186.110
// gc-shadow-fork-4-teku-nethermind-8          167.99.191.122
const txt = execSync(
  `doctl compute droplet list --tag-name ${tag} --no-header --format Name,PublicIPv4`,
  { encoding: "utf8" }
);

const hosts = txt
  .trim()
  .split("\n")
  .reverse()
  .map((row, i) => {
    const [name, ip] = row.split(/\s+/g);
    return { name, ip };
  });

const inventoryList = hosts
  .map(({ name, ip }, i) => {
    const from = indexOffset + i * 1000;
    const to = indexOffset + (i + 1) * 1000;
    return `${name}\t ansible_host=${ip}\t mnemonic={{mnemonic_0}} indexes=${from}..${to}`;
  })
  .join("\n");

const hostNames = hosts.map(({ name }) => name);

function onlyClient(clName) {
  return hosts
    .map(({ name }) => name)
    .filter((name) => name.includes(clName))
    .join("\n");
}

console.log(`
${inventoryList}

[eth2client_lighthouse]
${onlyClient("lighthouse")}

[eth2client_prysm]
${onlyClient("prysm")}

[eth2client_teku]
${onlyClient("teku")}

[eth2client_lodestar]
${onlyClient("lodestar")}

[eth2client_nimbus]
${onlyClient("nimbus")}

[eth1client_nethermind]
${onlyClient("nethermind")}
`);
