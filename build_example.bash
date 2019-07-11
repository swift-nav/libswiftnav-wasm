#!/usr/bin/env bash

set -x

LSN_ARCHIVE=/opt/libswiftnav/emsdk_build/libswiftnav.a
LSN_INCLUDE=/opt/libswiftnav/include

emcc example.c -o example.js \
  -s EXPORTED_FUNCTIONS='["_lsn_parity"]' \
  -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' \
  -I ${LSN_INCLUDE} \
  ${LSN_ARCHIVE} \
  -s MODULARIZE=1 \
  -s 'EXPORT_NAME="LSN"'
