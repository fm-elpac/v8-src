#!/usr/bin/env -S deno run -A
// build-deno-1.41/run_build.js

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

let is_android = env["TARGET"].includes("android");

if (is_android) {
  // fix `libz.so`
  cmd.push("export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib/");
}
// DEBUG
cmd.push("export RUST_BACKTRACE=1");
cmd.push("export DENO_SKIP_CROSS_BUILD_CHECK=1");

// run build.rs
cmd.push(exe_file);

// docker image name
function get_img(target) {
  if ("aarch64-linux-android" == target) {
    return "termux/termux-docker:aarch64";
  } else if ("x86_64-linux-android" == target) {
    return "termux/termux-docker:x86_64";
  } else if ("aarch64-unknown-linux-gnu" == target) {
    return "arm64v8/debian:bookworm-slim";
  }
}

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
];

if (is_android) {
  args = args.concat([
    "--entrypoint",
    "/entrypoint_root.sh",
  ]);
}

args = args.concat([
  get_img(env["TARGET"]),
  "bash",
  "-c",
  cmd.join(" && "),
]);

// DEBUG
console.log("RUN docker " + JSON.stringify(args));

let p = new Deno.Command("docker", {
  args,
}).spawn();

let { code } = await p.status;

Deno.exit(code);
