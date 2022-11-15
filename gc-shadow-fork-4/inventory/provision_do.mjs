import { execSync } from "node:child_process";

const tag = "gc-shadow-fork-4";
const hostsByClient = {
  "gc-shadow-fork-4-lighthouse-nethermind": 10,
  "gc-shadow-fork-4-prysm-nethermind": 10,
  "gc-shadow-fork-4-teku-nethermind": 10,
  "gc-shadow-fork-4-lodestar-nethermind": 6,
};

// nyc1    New York 1         true
// sgp1    Singapore 1        true
// lon1    London 1           true
// nyc3    New York 3         true
// ams3    Amsterdam 3        true
// fra1    Frankfurt 1        true
// tor1    Toronto 1          true
// blr1    Bangalore 1        true
// sfo3    San Francisco 3    true
const regions = ["nyc1", "sgp1", "lon1", "ams3", "tor1", "blr1"];

let counter = 0;

for (const [prefix, count] of Object.entries(hostsByClient)) {
  for (let i = 0; i < count; i++) {
    const region = regions[counter++ % regions.length];

    const txt = execSync(
      [
        "doctl compute droplet create",
        "--image ubuntu-22-04-x64",
        "--size s-8vcpu-16gb-amd",
        `--region ${region}`,
        "--ssh-keys d9:39:86:57:a3:09:f1:f0:27:42:00:6e:79:79:cb:ff", // Giacomo-GC
        "--ssh-keys 4e:22:f5:f7:88:20:0c:87:38:67:89:89:6e:7c:38:f3", // Lion remote control
        "--ssh-keys 13:da:72:42:4a:45:a0:fa:04:1e:eb:5b:a5:c1:2e:6a", // Lion gram
        `--tag-name ${tag} ${prefix}-${i}`,
      ].join(" "),
      { encoding: "utf8" }
    );
    console.log(txt);
  }
}
