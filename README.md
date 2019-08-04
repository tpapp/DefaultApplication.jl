# DefaultApplication.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
[![Build Status](https://travis-ci.org/tpapp/DefaultApplication.jl.svg?branch=master)](https://travis-ci.org/tpapp/DefaultApplication.jl)
[![Coverage Status](https://coveralls.io/repos/tpapp/DefaultApplication.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/tpapp/DefaultApplication.jl?branch=master)
[![codecov.io](http://codecov.io/github/tpapp/DefaultApplication.jl/coverage.svg?branch=master)](http://codecov.io/github/tpapp/DefaultApplication.jl?branch=master)

Julia library for opening a file with the default application determined by the OS.

## Motivation

Many packages implement variations on the same short code snippet. This package maintains a version that can be shared or tested.

This package intends to be very lightweight, and has no dependencies outside the standard libraries. Nevertheless, if you still don't want to use this as a dependency, you can of course also copy the code of `DefaultApplication.open()` to another package, but then you will have to repeat this to keep up with bugfixes and developments.

## Usage

```julia
import DefaultApplication
DefaultApplication.open("/some/file.png")
```

`open` is not exported from the package, because it would clash with `Base.open`.

## Status

| OS      | version      | status     |
|:--------|:-------------|:-----------|
| Linux   | Ubuntu 18.04 | works      |
| Linux   | Debian 8.0   | works      |
| Linux   | Ubuntu 16.04 | works (CI) |
| Windows | 10           | works      |
| OS X    | Darwin 17.7  | works      |

If your OS/version is missing, please test as described below and open an issue with the information so that this table can be extended.

## Testing

Currently there are only partial unit tests, since the functionality of this package is difficult to test without a desktop environment. Testing, bug reports, feature requests and PRs are welcome.

There is a utility function `DefaultApplication.test()` for testing, which prints information for bug reports:

```julia
julia> import DefaultApplication

julia> DefaultApplication.test()
┌ Info: opening text file with the default application
└   path = "/tmp/juliaT2oWTX.txt"
┌ Info: If the file was not opened, please copy the output and open an issue at
└ https://github.com/tpapp/DefaultApplication.jl/issues
Julia Version 0.7.0-beta2.26
Commit 299300a409* (2018-07-17 04:35 UTC)
Platform Info:
  OS: Linux (x86_64-linux-gnu)
  CPU: Intel(R) Core(TM) i7-6560U CPU @ 2.20GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-6.0.0 (ORCJIT, skylake)
Environment:
  JULIA_NIGHTLY_PARENT = ~/src
  JULIA_NIGHTLY_SYMLINK = ~/bin/julia-latest
Process(`xdg-open /tmp/juliaT2oWTX.txt`, ProcessRunning)
```

## Related documentation

- [`COMSPEC`](https://en.wikipedia.org/wiki/COMSPEC) (Windows)
- [`xdg-open`](https://linux.die.net/man/1/xdg-open) (Linux)
- [`open`](https://ss64.com/osx/open.html) (OS X)
