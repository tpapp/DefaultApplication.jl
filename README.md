# DefaultApplication.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
[![Build Status](https://travis-ci.org/tpapp/DefaultApplication.jl.svg?branch=master)](https://travis-ci.org/tpapp/DefaultApplication.jl)
[![Coverage Status](https://coveralls.io/repos/tpapp/DefaultApplication.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/tpapp/DefaultApplication.jl?branch=master)

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
| Linux   | Ubuntu 19.10 | works      |
| Linux   | Ubuntu 19.04 | works      |
| Linux   | Ubuntu 18.04 | works      |
| Linux   | Ubuntu 16.04 | works (CI) |
| Linux   | Debian 8.0   | works      |
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
└   path = "/tmp/jl_ISgu7A.txt"
┌ Info: If the file was not opened, please copy the output and open an issue at
└ https://github.com/tpapp/DefaultApplication.jl/issues
Julia Version 1.4.0-rc1.0
Commit b0c33b0cf5 (2020-01-23 17:23 UTC)
Platform Info:
  OS: Linux (x86_64-linux-gnu)
      Ubuntu 19.10
  uname: Linux 5.3.0-29-generic #31-Ubuntu SMP Fri Jan 17 17:27:26 UTC 2020 x86_64 x86_64
  CPU: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz:
              speed         user         nice          sys         idle          irq
       #1  3014 MHz     312924 s        452 s     102521 s    4773911 s          0 s
       #2  3005 MHz     392192 s        374 s      79742 s    1121314 s          0 s
       #3  3028 MHz     417948 s        275 s      80886 s    1122523 s          0 s
       #4  2984 MHz     400951 s        386 s      84294 s    1115707 s          0 s
       #5  2909 MHz     411316 s        613 s      82936 s    1120208 s          0 s
       #6  2878 MHz     386572 s        368 s      82815 s    1116943 s          0 s
       #7  3011 MHz     366070 s        673 s      92152 s    1123035 s          0 s
       #8  2997 MHz     383230 s        544 s      82892 s    1124208 s          0 s

  Memory: 15.518669128417969 GB (5564.16796875 MB free)
  Uptime: 86757.0 sec
  Load Avg:  0.58447265625  0.50439453125  0.505859375
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-8.0.1 (ORCJIT, skylake)
Environment:
  JULIA_NUM_THREADS = 1
  HOME = /home/tamas
  XDG_SEAT_PATH = /org/freedesktop/DisplayManager/Seat0
  MANDATORY_PATH = /usr/share/gconf/xubuntu.mandatory.path
  DEFAULTS_PATH = /usr/share/gconf/xubuntu.default.path
  TERM = eterm-color
  PATH = /home/tamas/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
  XDG_SESSION_PATH = /org/freedesktop/DisplayManager/Session0
  JULIA_CMDSTAN_HOME = /home/tamas/src/cmdstan/
Process(`xdg-open /tmp/jl_ISgu7A.txt`, ProcessRunning)
```

## Related documentation

- [`COMSPEC`](https://en.wikipedia.org/wiki/COMSPEC) (Windows)
- [`xdg-open`](https://linux.die.net/man/1/xdg-open) (Linux)
- [`open`](https://ss64.com/osx/open.html) (OS X)
