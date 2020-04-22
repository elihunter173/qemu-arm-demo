#!/usr/bin/env bats
# vim: ft=sh

@test "simple match" {
  run qemu-arm tictactoe < test_files/simple_match.txt
  [ "$status" -eq 0 ]
}

@test "simple scratch" {
  run qemu-arm tictactoe < test_files/simple_scratch.txt
  [ "$status" -eq 1 ]
}
