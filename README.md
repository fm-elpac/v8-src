# Build deno android

<https://github.com/fm-elpac/v8-src/tree/deno-1.41>

![build deno-1.41](https://github.com/fm-elpac/v8-src/actions/workflows/deno-1.41.yml/badge.svg)

This project build [`deno`](https://github.com/denoland/deno) for android
(aarch64), with the help of these tools:

本项目编译能在 Android (aarch64) 运行的 deno, 使用以下工具:

- [`termux-docker`](https://github.com/termux/termux-docker)

  provide the docker image for aarch64 android.

  提供 aarch64 Android 的 docker 镜像.

- [`cargo-cross-build`](https://github.com/fm-elpac/cargo-cross-build)

  run `build.rs` on target.

  在编译目标设备上运行 `build.rs`.

(See deno issue `#19759`: <https://github.com/denoland/deno/issues/19759>)
(详见这个问题)

- `aarch64-linux-android`

<!-- - `x86_64-linux-android` -->

Download deno binary: <https://github.com/fm-elpac/v8-src/releases>

请从发布页下载编译好的 deno 二进制可执行文件.

TODO
