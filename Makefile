
# copy code from ~/.cargo/registry/src/XXX/ to workdir/
fetch_code:
	mkdir -p workdir
	for i in $$(ls patch); do cp -r cargo_src/$$i workdir; done

clean:
	rm -r workdir

# build deno for `aarch64-linux-android`
deno:
	export RUSTY_V8_MIRROR=$$(pwd)/lib_v8 && \
	export PATH=$$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$$PATH && \
	export CC_aarch64_linux_android=aarch64-linux-android28-clang && \
	export CXX_aarch64_linux_android=aarch64-linux-android28-clang++ && \
	export AR_aarch64_linux_android=llvm-ar && \
	export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=aarch64-linux-android28-clang && \
	export CARGO_CROSS_BUILD_CRATES=deno_runtime:deno && \
	export CARGO_CROSS_BUILD_RS=deno_runtime-0.124.0/build.rs:deno-1.36.2/build.rs && \
	export CARGO_CROSS_BUILD_RUN=$$(pwd)/run_build.js && \
	cd workdir/deno-1.36.2 && \
	cargo +cross-build build -vv --release --target aarch64-linux-android

# build deno for `x86_64-linux-android`
deno_x86_64:
	export RUSTY_V8_MIRROR=$$(pwd)/lib_v8 && \
	export PATH=$$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$$PATH && \
	export CC_x86_64_linux_android=x86_64-linux-android28-clang && \
	export CXX_x86_64_linux_android=x86_64-linux-android28-clang++ && \
	export AR_x86_64_linux_android=llvm-ar && \
	export CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER=x86_64-linux-android28-clang && \
	export CARGO_CROSS_BUILD_CRATES=deno_runtime:deno && \
	export CARGO_CROSS_BUILD_RS=deno_runtime-0.124.0/build.rs:deno-1.36.2/build.rs && \
	export CARGO_CROSS_BUILD_RUN=$$(pwd)/run_build.js && \
	cd workdir/deno-1.36.2 && \
	cargo +cross-build build -vv --release --target x86_64-linux-android

# build deno for `aarch64-unknown-linux-gnu`
deno_gnu_aarch64:
	export RUSTY_V8_MIRROR=$$(pwd)/lib_v8 && \
	export CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc && \
	export CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++ && \
	export AR_aarch64_unknown_linux_gnu=aarch64-linux-gnu-ar && \
	export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc && \
	export CARGO_CROSS_BUILD_CRATES=deno_runtime:deno && \
	export CARGO_CROSS_BUILD_RS=deno_runtime-0.124.0/build.rs:deno-1.36.2/build.rs && \
	export CARGO_CROSS_BUILD_RUN=$$(pwd)/run_build.js && \
	cd workdir/deno-1.36.2 && \
	cargo +cross-build build -vv --release --target aarch64-unknown-linux-gnu
