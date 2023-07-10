// get_cargo_src.js
//
// symlink `cargo_src` -> ~/.cargo/registry/src/XXX/
//
// usage:
//   cargo metadata | deno run -A get_cargo_src.js
import { join as path_join } from "https://deno.land/std@0.193.0/path/posix.ts";
import { readAll } from "https://deno.land/std@0.193.0/streams/read_all.ts";

console.log("get_cargo_src.js");

// read stdin (json)
let b = await readAll(Deno.stdin);
let de = new TextDecoder();
let d = JSON.parse(de.decode(b));

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
