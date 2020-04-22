# example

This is a simple assembly program that uses Linux syscalls to perform file IO.
It includes automated testing using [bats].

The provided `Makefile` includes many utility commands. Here's a quick break
down of them.

* `make`: Build the `armkey` executable.
* `make run`: Build and run the `armkey` executable.
* `make debug`: Build and run the `armkey` executable with GDB.
* `make test`: Build and run automated tests on `armkey`.
* `make clean`: Remove the `armkey` executable and all `.o` files.

[bats]: https://github.com/bats-core/bats-core

**TODO:** Expand
