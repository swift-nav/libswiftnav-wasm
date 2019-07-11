#!/usr/bin/env bash

cd /opt/libswiftnav

mkdir emsdk_build
cd emsdk_build

cmake \
  -DCMAKE_C_COMPILER=$(command -v emcc) \
  -DCMAKE_CXX_COMPILER=$(command -v em++) \
  -DCMAKE_SHARED_LIBRARY_LINK_C_FLAGS="" \
  -DCMAKE_EXE_LINKER_FLAGS="" \
  -DCMAKE_AR=/opt/wasi-sdk/bin/llvm-ar \
  -DCMAKE_LINKER=/opt/wasi-sdk/bin/wasm-ld \
  -DCMAKE_RANLIB=/opt/wasi-sdk/bin/llvm-ranlib \
  ..

make

cd /opt/libswiftnav

mkdir wasi_build
cd wasi_build

cmake \
  -DCMAKE_C_COMPILER=/opt/wasi-sdk/bin/clang \
  -DCMAKE_CXX_COMPILER=/opt/wasi-sdk/bin/clang++ \
  -DCMAKE_SHARED_LIBRARY_LINK_C_FLAGS="" \
  -DCMAKE_EXE_LINKER_FLAGS="" \
  -DCMAKE_AR=/opt/wasi-sdk/bin/llvm-ar \
  -DCMAKE_LINKER=/opt/wasi-sdk/bin/wasm-ld \
  -DCMAKE_RANLIB=/opt/wasi-sdk/bin/llvm-ranlib \
  ..

make
