An experiement with compiling the libswiftnav repo to WebAssembly (WASM).

The following steps will build a docker container that can compile
libswiftnav to WASM:

- `./build_docker.bash` ([source](./build_docker.bash))

- `./run_docker.bash` ([source](./run_docker.bash))

- `./build_example.bash` ([source](./build_example.bash))

Then outside the container run

- `./serve_wasm` ([source](./serve_wasm))

Visit [http://localhost:8888](http://localhost:8888) to execute the WASM
module.  Open the debug console of the browser to see the results of the calls
to the `parity` function in libswiftnav.

The source of the web page is in `index.html` ([source](./index.html)).

The [build_lsn.bash](./build_lsn.bash) does the work of compiling the library for 2 different WASM environments.
The first is [Emscripten](https://emscripten.org/) which allows the code to run in the browser.  And the second
is [WASI](https://wasi.dev/) via its [SDK](https://github.com/CraneStation/wasi-sdk).
