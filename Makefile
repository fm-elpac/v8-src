
# copy code from ~/.cargo/registry/src/XXX/ to workdir/
fetch_code:
	mkdir -p workdir
	for i in $$(ls patch); do cp -r cargo_src/$$i workdir; done

deno-mksnapshot-runtime:
	export RUSTY_V8_MIRROR=$$(pwd)/lib_v8 && \
	export PATH=$$NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin:$$PATH && \
	export CC_aarch64_linux_android=aarch64-linux-android28-clang && \
	export CXX_aarch64_linux_android=aarch64-linux-android28-clang++ && \
	export AR_aarch64_linux_android=llvm-ar && \
	export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=aarch64-linux-android28-clang && \
	cd workdir/deno_runtime-0.118.0 && \
	cargo build --release --target aarch64-linux-android

# copy .d.ts files
dts_file:
	cp -r workdir/deno-1.35.0/tsc snapshot_bin
	mkdir snapshot_bin/deno_websocket
	cp workdir/deno_websocket-*/lib.deno_websocket.d.ts snapshot_bin/deno_websocket
	mkdir snapshot_bin/deno_core
	cp workdir/deno_core-*/internal.d.ts snapshot_bin/deno_core
	cp workdir/deno_core-*/lib.deno_core.d.ts snapshot_bin/deno_core
	mkdir snapshot_bin/deno_broadcast_channel
	cp workdir/deno_broadcast_channel-*/lib.deno_broadcast_channel.d.ts snapshot_bin/deno_broadcast_channel
	mkdir snapshot_bin/deno_cache
	cp workdir/deno_cache-*/lib.deno_cache.d.ts snapshot_bin/deno_cache
	mkdir snapshot_bin/deno_console
	cp workdir/deno_console-*/internal.d.ts snapshot_bin/deno_console
	cp workdir/deno_console-*/lib.deno_console.d.ts snapshot_bin/deno_console
	mkdir snapshot_bin/deno_crypto
	cp workdir/deno_crypto-*/lib.deno_crypto.d.ts snapshot_bin/deno_crypto
	mkdir snapshot_bin/deno_fetch
	cp workdir/deno_fetch-*/internal.d.ts snapshot_bin/deno_fetch
	cp workdir/deno_fetch-*/lib.deno_fetch.d.ts snapshot_bin/deno_fetch
	mkdir snapshot_bin/deno_net
	cp workdir/deno_net-*/lib.deno_net.d.ts snapshot_bin/deno_net
	mkdir snapshot_bin/deno_url
	cp workdir/deno_url-*/internal.d.ts snapshot_bin/deno_url
	cp workdir/deno_url-*/lib.deno_url.d.ts snapshot_bin/deno_url
	mkdir snapshot_bin/deno_web
	cp workdir/deno_web-*/internal.d.ts snapshot_bin/deno_web
	cp workdir/deno_web-*/lib.deno_web.d.ts snapshot_bin/deno_web
	mkdir snapshot_bin/deno_webidl
	cp workdir/deno_webidl-*/internal.d.ts snapshot_bin/deno_webidl
	mkdir snapshot_bin/deno_webstorage
	cp workdir/deno_webstorage-*/lib.deno_webstorage.d.ts snapshot_bin/deno_webstorage

deno-mksnapshot:
	export RUSTY_V8_MIRROR=$$(pwd)/lib_v8 && \
	export PATH=$$NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin:$$PATH && \
	export CC_aarch64_linux_android=aarch64-linux-android28-clang && \
	export CXX_aarch64_linux_android=aarch64-linux-android28-clang++ && \
	export AR_aarch64_linux_android=llvm-ar && \
	export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=aarch64-linux-android28-clang && \
	export OUT_DIR=$$(pwd)/snapshot_bin && \
	export TARGET=aarch64-linux-android && \
	cd workdir/deno-1.35.0 && \
	cargo build --release --target aarch64-linux-android

deno:
	export RUSTY_V8_MIRROR=$$(pwd)/lib_v8 && \
	export PATH=$$NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin:$$PATH && \
	export CC_aarch64_linux_android=aarch64-linux-android28-clang && \
	export CXX_aarch64_linux_android=aarch64-linux-android28-clang++ && \
	export AR_aarch64_linux_android=llvm-ar && \
	export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=aarch64-linux-android28-clang && \
	export OUT_DIR=$$(pwd)/snapshot_bin && \
	export TARGET=aarch64-linux-android && \
	export PROFILE=release && \
	export GIT_COMMIT_HASH_SHORT=xxx && \
	export GIT_COMMIT_HASH=xxxxxx && \
	export TS_VERSION="5.1.6" && \
	cd workdir/deno-1.35.0 && \
	cargo build --release --target aarch64-linux-android

clean:
	rm -r workdir
