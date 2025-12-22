        .text
        .globl _start
_start:

# ---------- 1) Test ADD, SUB, logic, SLT/SLTU ----------

        addi x1, x0, 5         # x1 = 5
        addi x2, x0, 10        # x2 = 10

        add  x3, x1, x2        # x3 = 5 + 10 = 15
        sub  x4, x2, x1        # x4 = 10 - 5 = 5

        and  x5, x1, x2        # x5 = 5 & 10
        or   x6, x1, x2        # x6 = 5 | 10
        xor  x7, x1, x2        # x7 = 5 ^ 10

        slt  x8, x1, x2        # x8 = 1 (5 < 10 signed)
        slt  x9, x2, x1        # x9 = 0 (10 < 5 signed? no)

        sltu x10, x1, x2       # x10 = 1 (5 < 10 unsigned)
        sltu x11, x2, x1       # x11 = 0

# ---------- 2) Test immediate logical, compare, shifts ----------

        addi x12, x0, 15       # x12 = 15  (0b0000_1111)
        andi x13, x12, 3       # x13 = 15 & 3 = 3
        ori  x14, x0, 8        # x14 = 8
        xori x15, x12, 0xF     # x15 = 15 ^ 15 = 0

        addi x16, x0, 7        # x16 = 7
        slti x17, x16, 10      # x17 = 1 (7 < 10 signed)
        sltiu x18, x16, 10     # x18 = 1 (7 < 10 unsigned)

        slli x19, x16, 1       # x19 = 7 << 1 = 14
        srli x20, x16, 1       # x20 = 7 >> 1 = 3 (logical)
        srai x21, x16, 1       # x21 = 7 >> 1 = 3 (arith)

# ---------- 3) Test register-based shifts (sll, srl, sra) ----------

        addi x22, x0, 1        # shift amount = 1
        sll  x23, x16, x22     # x23 = 7 << 1 = 14
        srl  x24, x16, x22     # x24 = 7 >> 1 = 3 (logical)
        sra  x25, x16, x22     # x25 = 7 >> 1 = 3 (arith)

# ---------- 4) Test memory: sw / lw (offset = 0 only) ----------

        # base = 0x100
        addi x26, x0, 0x100    # x26 = 0x100

        # store x3 at [0x100]
        sw   x3, 0(x26)

        # store x4 at [0x104] using base change
        addi x26, x26, 4       # x26 = 0x104
        sw   x4, 0(x26)

        # load back
        addi x26, x0, 0x100    # x26 = 0x100
        lw   x27, 0(x26)       # x27 = [0x100] = 15

        addi x26, x26, 4       # x26 = 0x104
        lw   x28, 0(x26)       # x28 = [0x104] = 5

# ---------- 5) Simple loop using beq / bne ----------

        addi x29, x0, 5        # x29 = counter = 5
        addi x30, x0, 0        # x30 = sum = 0

loop:
        beq  x29, x0, done     # if counter == 0 -> exit loop

        add  x30, x30, x29     # sum += counter
        addi x29, x29, -1      # counter--

        bne  x29, x0, loop     # if counter != 0 -> repeat

done:
        # Now x30 should = 5 + 4 + 3 + 2 + 1 = 15

end:
        beq  x0, x0, end       # infinite loop (halt)
