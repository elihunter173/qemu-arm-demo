.include "req_syscalls.s"

// TODO: Make it actually report the winner.
// This does no error handling

.equ O, 'o'
.equ X, 'x'
.equ BLANK, ' '

.equ BOARD_ROWS, 3
// Last column is dummy column reserved for newline. Makes parsing easier
.equ BOARD_COLS, 4
.equ BOARD_SIZE, BOARD_ROWS * BOARD_COLS

.equ ERR_BAD_BOARD, 128

.data
ERRMSG_BAD_BOARD: .ascii "Invalid board. Board must be 3 by 3 with rows split by newlines"
.equ ERRMSG_BAD_BOARD_LEN, . - ERRMSG_BAD_BOARD

.bss
board: .skip BOARD_SIZE

.text
.global _start
_start:
    // read(FD_STDIN, board, BOARD_SIZE)
    // read_head (r1) = board
    ldr r0, =FD_STDIN
    ldr r1, =board
    ldr r2, =BOARD_SIZE
    ldr r7, =SYS_READ
    swi 0x0
    cmp r0, #BOARD_SIZE
    ldr r0, =board

    // Start at row 2 and go down to row 1
    add r1, r0, #(2 * BOARD_COLS)
check_horz:
    ldrb r2, [r1, #0]
    ldrb r3, [r1, #1]
    cmp r2, r3
    bne check_horz_next
    ldrb r4, [r1, #2]
    cmp r2, r4
    beq match
check_horz_next:
    sub r1, r1, #BOARD_COLS
    cmp r1, r0
    bne check_horz

    // Start at col 2 and go down to col 1
    add r1, r0, #2
check_vert:
    ldrb r2, [r1, #(0 * BOARD_COLS)]
    ldrb r3, [r1, #(1 * BOARD_COLS)]
    cmp r2, r3
    bne check_vert_next
    ldrb r4, [r1, #(2 * BOARD_COLS)]
    cmp r2, r4
    beq match
check_vert_next:
    sub r1, r1, #1
    cmp r1, r0
    bne check_vert

check_neg_diagonal:
    ldrb r2, [r0, #(0 * BOARD_COLS + 0)]
    ldrb r3, [r0, #(1 * BOARD_COLS + 1)]
    cmp r2, r3
    bne check_neg_diagonal_after
    ldrb r4, [r0, #(2 * BOARD_COLS + 2)]
    cmp r2, r4
    beq match
check_neg_diagonal_after:

check_pos_diagonal:
    ldrb r2, [r0, #(0 * BOARD_COLS + 2)]
    ldrb r3, [r0, #(1 * BOARD_COLS + 1)]
    cmp r2, r3
    bne check_pos_diagonal_after
    ldrb r4, [r0, #(2 * BOARD_COLS + 0)]
    cmp r2, r4
    beq match
check_pos_diagonal_after:

no_match:
    ldr r0, =EXIT_FAILURE
    ldr r7, =SYS_EXIT
    swi 0x0

match:
    ldr r0, =EXIT_SUCCESS
    ldr r7, =SYS_EXIT
    swi 0x0
