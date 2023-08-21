#!/usr/bin/env -S deno run -A
// build-deno-1.36/run_build.js

console.log("run_build.js");

let exe_file = Deno.args[0];
let env = Deno.env.toObject();

console.log(exe_file);
console.log(JSON.stringify(env, "", "  "));

// command to run
let cmd = [
  `cd ${Deno.cwd()}`,
];

// pass env var
let env_list = [
  "TARGET",
  "PROFILE",
  "OUT_DIR",
  "HOST",
  "CARGO_MANIFEST_DIR",
];

for (let i of env_list) {
  cmd.push(`export ${i}=${env[i]}`);
}

// fix `libz.so`
cmd.push("export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib/");
// DEBUG
cmd.push("export RUST_BACKTRACE=1");

// run build.rs
cmd.push(exe_file);

let workdir = env["WORKDIR"];
let cargo_dir = env["CARGO_DIR"];
// docker run
let args = [
  "run",
  "--rm",
  "--privileged",
  "--mount",
  `type=bind,src=${workdir},target=${workdir}`,
  "--mount",
  `type=bind,src=${cargo_dir},target=${cargo_dir}`,
  "--entrypoint",
  "/entrypoint_root.sh",
  "termux/termux-docker:aarch64",
  "bash",
  "-c",
  cmd.join(" && "),
];

// DEBUG
console.log("RUN docker " + JSON.stringify(args));

let p = new Deno.Command("docker", {
  args,
}).spawn();

let { code } = await p.status;

Deno.exit(code);
