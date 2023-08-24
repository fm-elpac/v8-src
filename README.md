# Build deno android

<https://github.com/fm-elpac/v8-src/tree/deno-1.36>

![build deno-1.36](https://github.com/fm-elpac/v8-src/actions/workflows/deno-1.36.yml/badge.svg)

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

- `x86_64-linux-android`

Download deno binary: <https://github.com/fm-elpac/v8-src/releases>

请从发布页下载编译好的 deno 二进制可执行文件.

## What does not work

Currently known BUG:

已知 BUG:

- ICU

- `deno_ffi`

The test suite is not run, so maybe more not work !

没有在 Android 上运行自动化测试, 可能有更多 BUG !

## Test run

运行测试:

- `aarch64-linux-android`

```
> adb shell
violet:/ $ cd /data/local/tmp/deno-test/10
violet:/data/local/tmp/deno-test/10 $ ls -l
drwxrwxrwx  3 shell shell      3488 2023-08-21 16:59 .cache
-rwxrwxrwx  1 shell shell 149546432 2023-08-21 20:27 deno
violet:/data/local/tmp/deno-test/10 $ ./deno --version
deno 1.36.1 (release, aarch64-linux-android)
v8 11.7.439.1
typescript 5.1.6
violet:/data/local/tmp/deno-test/10 $ export HOME=$(pwd)
violet:/data/local/tmp/deno-test/10 $ ./deno
Deno 1.36.1
exit using ctrl+d, ctrl+c, or close()
REPL is running with all permissions allowed.
To specify permissions, run `deno repl` with allow flags.
> 0.1 + 0.2
0.30000000000000004
> Deno.version
{ deno: "1.36.1", v8: "11.7.439.1", typescript: "5.1.6" }
>
```
