# Nix configuration for building LaTeX documents

This repository contains instructions and a `nix flakes` setup needed for building
`LaTeX` documents in a reproducible manner.

## Building LaTeX documents

To build the latex document run:

```shell
nix build .
```

After running this command look inside the `result` directory.

For a continuous compilation of the `LaTeX` file run:

```shell
nix develop -c "make watch"
```

## Adding packages

Most likely you will need other `LaTeX` packages. These can be added in the `flake.nix` file.

Note that when adding a new package, it might be necessary to run:

```shell
nix develop -c "make clean"
```
## Improve your workflow further by using lorri

If you install and configure [`lorri`](https://github.com/target/lorri) then it
is not necessary to use the `nix develop` command, and one can use `make`
directly. See the project documentation for details on how to use it.
