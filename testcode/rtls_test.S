.section .text
.global _start
_start:
    # Reset all registers (x0 - x31)
    addi x1, x0, 0   
    addi x2, x0, 0   
    addi x3, x0, 0   
    addi x4, x0, 0   
    addi x5, x0, 0   
    addi x6, x0, 0   
    addi x7, x0, 0   
    addi x8, x0, 0   
    addi x9, x0, 0   
    addi x10, x0, 0   
    addi x11, x0, 0   
    addi x12, x0, 0   
    addi x13, x0, 0   
    addi x14, x0, 0   
    addi x15, x0, 0   
    addi x16, x0, 0   
    addi x17, x0, 0   
    addi x18, x0, 0   
    addi x19, x0, 0   
    addi x20, x0, 0   
    addi x21, x0, 0   
    addi x22, x0, 0   
    addi x23, x0, 0   
    addi x24, x0, 0   
    addi x25, x0, 0   
    addi x26, x0, 0   
    addi x27, x0, 0   
    addi x28, x0, 0   
    addi x29, x0, 0   
    addi x30, x0, 0   
    addi x31, x0, 0   

    # Store float bit patterns into memory
    # Base address for storing constants temporarily
    la a0, float_temp

    li t0, 0x3F000000   # 0.5
    sw t0,  0(a0)       # Store p0.x (0.5)
    li t0, 0x3F19999A   # 0.6
    sw t0,  4(a0)       # Store p0.y (0.6)
    li t0, 0x3F333333   # 0.7
    sw t0,  8(a0)       # Store p0.z (0.7)

    li t0, 0x3F800000   # 1.0
    sw t0, 12(a0)       # Store p1.x (1.0)
    li t0, 0x40000000   # 2.0
    sw t0, 16(a0)       # Store p1.y (2.0)
    li t0, 0x40400000   # 3.0
    sw t0, 20(a0)       # Store p1.z (3.0)

    li t0, 0x40800000   # 4.0
    sw t0, 24(a0)       # Store p2.x (4.0)
    li t0, 0x40A00000   # 5.0
    sw t0, 28(a0)       # Store p2.y (5.0)
    li t0, 0x40C00000   # 6.0
    sw t0, 32(a0)       # Store p2.z (6.0)

    li t0, 0x3F000000   # 0.5
    sw t0, 36(a0)       # Store r0.x (0.5)
    li t0, 0x3F000000   # 0.5
    sw t0, 40(a0)       # Store r0.y (0.5)
    li t0, 0x00000000   # 0.0
    sw t0, 44(a0)       # Store r0.z (0.0)

    li t0, 0x00000000   # 0.0
    sw t0, 48(a0)       # Store rd.x (0.0)
    li t0, 0x00000000   # 0.0
    sw t0, 52(a0)       # Store rd.y (0.0)
    li t0, 0x3F800000   # 1.0
    sw t0, 56(a0)       # Store rd.z (1.0)

    # Now load into FP registers
#    .word 0x00056087
#    .word 0x00056107
#    .word 0x00056187
#    .word 0x00056207
#    .word 0x00056287
#    .word 0x00056307
#    .word 0x00056387
#    .word 0x00056407
#    .word 0x00056487
#    .word 0x00056507
#    .word 0x00056587
#    .word 0x00056607
#    .word 0x00056687
#    .word 0x00056707
#    .word 0x00056787

.word 0x00056087   # imm=0,   rd=x1,  rs1=x10, funct3=6, opcode=0x07
.word 0x00456107   # imm=4,   rd=x2
.word 0x00856187   # imm=8,   rd=x3
.word 0x00C56207   # imm=12,  rd=x4
.word 0x01056287   # imm=16,  rd=x5
.word 0x01456307   # imm=20,  rd=x6
.word 0x01856387   # imm=24,  rd=x7
.word 0x01C56407   # imm=28,  rd=x8
.word 0x02056487   # imm=32,  rd=x9
.word 0x02456507   # imm=36,  rd=x10
.word 0x02856587   # imm=40,  rd=x11
.word 0x02C56607   # imm=44,  rd=x12
.word 0x03056687   # imm=48,  rd=x13
.word 0x03456707   # imm=52,  rd=x14
.word 0x03856787   # imm=56,  rd=x15


    # Done
    nop
    .word 0x000010FB

    j .  # Infinite loop to avoid falling through

# Memory region to hold float constants temporarily
.section .text
.align 2
float_temp:
    .space 60  # 15 floats * 4 bytes = 60 bytes
