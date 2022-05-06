/**
  @author Eli W. Hunter
  @file req_syscalls.s

  Collection of syscall-related constants required to complete tictactoe.s.
*/

// Linux syscall numbers for ARM32. See
// https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md#arm-32_bit_EABI
.equ SYS_EXIT, 1
.equ SYS_READ, 3
.equ SYS_WRITE, 4
.equ SYS_OPEN, 5
.equ SYS_CLOSE, 6

// Flags for the `open` Linux syscall from <fcntl.h>. (specifically
// <bits/fcntl-linux.h>)
.equ O_RDONLY, 00
.equ O_WRONLY, 01
.equ O_CREAT, 0100
.equ O_TRUNC, 01000

.equ false, 0
.equ true, 1

.equ FD_STDIN, 0
.equ FD_STDOUT, 1
.equ FD_STDERR, 2

.equ EXIT_SUCCESS, 0
.equ EXIT_FAILURE, 1
