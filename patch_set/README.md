# patch_set

- generate patch file:

  ```sh
  diff -ru -x Cargo.lock workdir-1 workdir > patch_set/p1.patch
  ```

- apply patch:

  ```sh
  cd workdir && patch -p1 < ../patch_set/p1.patch
  ```

TODO
