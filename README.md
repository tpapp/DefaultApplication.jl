# DefaultApplication.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)

Julia library for opening a file with the default application determined by the OS.

## Motivation

Many packages implement variations on the same short code snippet. This package maintains a version that can be shared or tested.

## Usage

```julia
import DefaultApplication
DefaultApplication.open("/some/file.png")
```

`open` is not exported from the package, because it would clash with `Base.open`.

## Testing

Currently there are no unit test since these things are tricky to test for, but testing, bug reports, feature requests and PRs are welcome.

There is a utility function `DefaultApplication.test()` for testing, which prints information for bug reports:

```julia
julia> import DefaultApplication

julia> DefaultApplication.test()
┌ Info: opening text file with the default application
└   path = "/tmp/juliaIiNmIf.txt"
┌ Info: If the file was not opened, please copy the output and open an issue at
│ https://github.com/tpapp/DefaultApplication.jl/issues
│   KERNEL = :Linux
└   VERSION = v"0.7.0-beta2.1"
```

## Status

| OS      | version      | status |
|:--------|:-------------|:-------|
| Linux   | Ubuntu 18.04 | works  |
| Linux   | Debian 8.0   | works  |

## Related documentation

- [`COMSPEC`](https://en.wikipedia.org/wiki/COMSPEC) (Windows)
- [`xdg-open`](https://linux.die.net/man/1/xdg-open) (Linux)
- [`open`](https://ss64.com/osx/open.html) (OS X)
