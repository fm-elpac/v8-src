
# copy code from ~/.cargo/registry/src/XXX/ to workdir/
fetch_code:
	mkdir -p workdir
	for i in $$(ls patch); do cp -r cargo_src/$$i workdir; done

clean:
	rm -r workdir

deno:
	export RUSTY_V8_MIRROR=$$(pwd)/lib_v8 && \
	export PATH=$$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$$PATH && \
	export CC_aarch64_linux_android=aarch64-linux-android28-clang && \
	export CXX_aarch64_linux_android=aarch64-linux-android28-clang++ && \
	export AR_aarch64_linux_android=llvm-ar && \
	export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=aarch64-linux-android28-clang && \
	export CARGO_CROSS_BUILD_CRATES=deno_runtime:deno && \
	export CARGO_CROSS_BUILD_RS=deno_runtime-0.123.0/build.rs:deno-1.36.1/build.rs && \
	export CARGO_CROSS_BUILD_RUN=$$(pwd)/run_build.js && \
	cd workdir/deno-1.36.1 && \
	cargo +cross-build build -vv --release --target aarch64-linux-android
