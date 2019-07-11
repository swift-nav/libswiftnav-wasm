#!/usr/bin/env bash

set -x

LSN_ARCHIVE=/opt/libswiftnav/wasi_build/libswiftnav.a
LSN_INCLUDE=/opt/libswiftnav/include

/opt/wasi-sdk/bin/clang \
  -o example_main.wasm example_main.c \
  -I ${LSN_INCLUDE} \
  ${LSN_ARCHIVE}
