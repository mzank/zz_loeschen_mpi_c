# ZZ Loeschen MPI C

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Documentation](https://img.shields.io/badge/docs-GitHub%20Pages-green.svg)](https://mzank.github.io/zz_loeschen_mpi_c/)

My test for GitHub Pages and C code with MPI.

---

## Building the Project

Configure the project (using the default preset):

```bash
cmake --preset default
```

Build all targets:

```bash
cmake --build --preset default --parallel
```

After building, the compiled binaries are placed in the `build/default/bin` directory.

Plain `cmake -S . -B build` invocations work as well; the presets are a convenience that pins the common cache options.

---

## Documentation

If Doxygen is installed, HTML documentation can be generated with:

```bash
cmake --preset docs
cmake --build --preset docs
```

The generated documentation is located at:

```text
build/docs/html/index.html
```

---

## Testing

The unit tests are built with the project and can be run with CTest:

```bash
cmake --preset default
cmake --build --preset default
ctest --preset default
```

The test results are reported in the terminal. The tests are only available if `BUILD_TESTING` is enabled (the default).

---

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.

You can also view the license here: https://www.apache.org/licenses/LICENSE-2.0

---
