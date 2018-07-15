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

You can use the following short snippet for testing:

```julia
import DefaultApplication
file = tempname() * ".txt"
write(file, "some text")
DefaultApplication.open(file)
```

## Related documentation

- [`COMSPEC`](https://en.wikipedia.org/wiki/COMSPEC) (Windows)
- [`xdg-open`](https://linux.die.net/man/1/xdg-open) (Linux)
- [`open`](https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man1/open.1.html) (OS X)
