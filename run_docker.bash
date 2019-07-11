#!/usr/bin/env bash
docker run -v wasm-root:/root -v $PWD:/work -it --rm wasm:latest /bin/bash
