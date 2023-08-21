# patch_set

- generate patch file:

  ```sh
  diff -ru -x Cargo.lock workdir-1 workdir > patch_set/p1.patch
  ```

- apply patch:

  ```sh
  cd workdir && patch -p1 < ../patch_set/p1.patch
  ```

- make a custom rust toolchain:

  ```sh
  cp -r ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu ~/.rustup/toolchains/cross-build
  ```

- build deno:

  ```sh
  cargo +cross-build build --release --target aarch64-linux-android
  ```

TODO
