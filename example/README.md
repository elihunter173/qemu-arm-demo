# example

This is a simple assembly program that takes in a finished ASCII tic-tac-toe
board from standard input and checks whether someone won the game or whether the
game was a scratch. If the game was a scratch, it exits with status 1. If
someone won, it exits with status 0. The program as provided does no error
checking that the board provided is valid, doesn't report who won, and doesn't
work properly for in-progress boards, but these could be potential enhancements
or requirements if the assignment was meant to be more difficult.

While this isn't a very interesting program, it does demonstrate usage of basic
Linux syscalls to perform file IO, involves pointer/array indexing in assembly,
and includes automated tests using [bats].

## Usage

The provided `Makefile` includes many utility commands:

* `make`: Build the `armkey` executable.
* `make run`: Build and run the `armkey` executable.
* `make debug`: Build and run the `armkey` executable with GDB.
* `make test`: Build and run automated tests on `armkey`.
* `make clean`: Remove the `armkey` executable and all `.o` files.

[bats]: https://github.com/bats-core/bats-core
