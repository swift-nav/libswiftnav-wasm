FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /work

RUN \
     echo '>>> Setting up ARM build environment...' \
  && apt-get update \
  && apt-get install -y wget bzip2 build-essential python3 \
  && apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev \
                        libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev \
                        libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev \
                        libffi-dev cmake ccache binutils-dev ninja-build \
                        gperf gawk flex bison ncurses-dev m4 patchelf \
                        texinfo help2man libpthread-stubs0-dev libtinfo-dev \
                        libatlas-base-dev libsqlite3-dev tk-dev libgdbm-dev \
                        libc6-dev llvm-8 vim curl wget silversearcher-ag \
                        libclang-dev ca-certificates file clang-8 git


# Install WASI SDK

ENV WASI_SDK_URL=https://github.com/CraneStation/wasi-sdk/releases/download/wasi-sdk-5/wasi-sdk_5.0_amd64.deb
RUN \
     wget ${WASI_SDK_URL} -O /tmp/wasi-sdk.deb \
  && dpkg -i /tmp/wasi-sdk.deb \
  && rm /tmp/wasi-sdk.deb

## WASI SDK overrides default clang, don't add to path by default
#ENV PATH=/opt/wasi-sdk/bin:${PATH}

# Install wasmer

RUN curl https://get.wasmer.io -sSfL | sh
ENV PATH=/root/.wasmer/bin:${PATH}

# Install Rust

ENV RUSTUP_HOME=/rust
ENV CARGO_HOME=/cargo 

ENV PATH=/cargo/bin:/rust/bin:${PATH}

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable --no-modify-path

RUN \
      git clone https://github.com/emscripten-core/emsdk.git /opt/emsdk \
   && cd /opt/emsdk \
   && ./emsdk install latest \
   && ./emsdk activate latest

ENV PATH=/opt/emsdk:/opt/emsdk/fastcomp/emscripten:/opt/emsdk/node/8.9.1_64bit/bin:${PATH}

RUN mkdir -p /scripts
ADD build_lsn.bash /scripts

RUN \
      git clone --recursive https://github.com/swift-nav/libswiftnav.git /opt/libswiftnav  \
   && cd /opt/libswiftnav \
   && /scripts/build_lsn.bash
