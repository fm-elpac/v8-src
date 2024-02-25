// get_cargo_src.js
//
// symlink `cargo_src` -> ~/.cargo/registry/src/XXX/
//
// usage:
//   cargo metadata | deno run -A get_cargo_src.js
import { join as path_join } from "https://deno.land/std@0.217.0/path/mod.ts";
import { toJson } from "https://deno.land/std@0.217.0/streams/to_json.ts";

console.log("get_cargo_src.js");

// read stdin (json)
let d = await toJson(Deno.stdin.readable);

function find_v8_path(d) {
  for (let i of d.packages) {
    for (let j of i.targets) {
      if (j.name == "v8") {
        return j.src_path;
      }
    }
  }
  return null;
}

let v8_path = find_v8_path(d);
if (v8_path == null) {
  console.log("ERROR: not found v8 path");
  Deno.exit(1);
}

console.log(v8_path);
let cargo_src = path_join(v8_path, "../../../");

console.log("    " + cargo_src);
await Deno.symlink(cargo_src, "cargo_src");
