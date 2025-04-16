	.file	"hello_world.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_a2p1_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/david/ECE511/final_project/RI5CY/riscv/tb/core" "custom/hello_world.c"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB3:
	.file 1 "custom/hello_world.c"
	.loc 1 7 12
	.cfi_startproc
	.loc 1 9 5
	.loc 1 7 12 is_stmt 0
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	ra,12(sp)
	.cfi_offset 1, -4
	.loc 1 9 5
	call	init_stats
.LVL0:
	.loc 1 12 5 is_stmt 1
	.loc 1 13 5
	.loc 1 14 5
	.loc 1 17 5
	.loc 1 18 5
	.loc 1 21 5
	.loc 1 22 5
	.loc 1 25 5
	.loc 1 26 5
	.loc 1 27 5
	.loc 1 30 5
	.loc 1 31 5
	.loc 1 32 5
	.loc 1 33 9
	.loc 1 33 14
	.loc 1 33 27 discriminator 1
	.loc 1 37 5
	.loc 1 37 16
	.loc 1 37 27
	.loc 1 40 5
	.loc 1 41 5
	.loc 1 42 5
	.loc 1 44 5
	.loc 1 45 5
	.loc 1 48 5
	.loc 1 49 5
	.loc 1 50 5
	.loc 1 53 5
	.loc 1 54 5
	.loc 1 55 5
	.loc 1 56 5
	.loc 1 58 5
	.loc 1 62 12
	.loc 1 67 9
	.loc 1 68 9
	.loc 1 69 9
	.loc 1 73 5
	.loc 1 74 5
	.loc 1 75 9
	.loc 1 76 9
	.loc 1 78 5
	.loc 1 80 5
	call	stats
.LVL1:
	.loc 1 82 5
	.loc 1 83 5
	.loc 1 86 1 is_stmt 0
	lw	ra,12(sp)
	.cfi_restore 1
	.loc 1 83 13
	li	a5,123457536
	li	a4,536870912
	addi	a5,a5,-747
	sw	a5,0(a4)
	.loc 1 85 5 is_stmt 1
	.loc 1 86 1 is_stmt 0
	li	a0,1
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.text
.Letext0:
	.file 2 "custom/firmware.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x34a
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.uleb128 0x6
	.4byte	.LASF21
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.LLRL0
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF2
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF3
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF9
	.uleb128 0x7
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x8
	.4byte	0x5e
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x2
	.byte	0x10
	.byte	0x4
	.4byte	.LASF11
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF12
	.uleb128 0x4
	.4byte	.LASF13
	.byte	0x23
	.uleb128 0x4
	.4byte	.LASF14
	.byte	0x22
	.uleb128 0x9
	.4byte	.LASF22
	.byte	0x1
	.byte	0x7
	.byte	0x5
	.4byte	0x5e
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x33b
	.uleb128 0x1
	.string	"p0x"
	.byte	0xc
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"p0y"
	.byte	0xc
	.byte	0x17
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"p0z"
	.byte	0xc
	.byte	0x23
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"p1x"
	.byte	0xd
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"p1y"
	.byte	0xd
	.byte	0x17
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"p1z"
	.byte	0xd
	.byte	0x23
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"p2x"
	.byte	0xe
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"p2y"
	.byte	0xe
	.byte	0x17
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"p2z"
	.byte	0xe
	.byte	0x23
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"ex"
	.byte	0x11
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3e4ccccd
	.uleb128 0x1
	.string	"ey"
	.byte	0x11
	.byte	0x16
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3e4ccccd
	.uleb128 0x1
	.string	"ez"
	.byte	0x11
	.byte	0x21
	.4byte	0x33b
	.byte	0x4
	.4byte	0xbf800000
	.uleb128 0x1
	.string	"dx"
	.byte	0x12
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"dy"
	.byte	0x12
	.byte	0x16
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"dz"
	.byte	0x12
	.byte	0x21
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"e1x"
	.byte	0x15
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"e1y"
	.byte	0x15
	.byte	0x1c
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"e1z"
	.byte	0x15
	.byte	0x2d
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"e2x"
	.byte	0x16
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"e2y"
	.byte	0x16
	.byte	0x1c
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"e2z"
	.byte	0x16
	.byte	0x2d
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"nx"
	.byte	0x19
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"ny"
	.byte	0x1a
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"nz"
	.byte	0x1b
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x3
	.4byte	.LASF15
	.byte	0x1e
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"len"
	.byte	0x1f
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x3
	.4byte	.LASF16
	.byte	0x28
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x3
	.4byte	.LASF17
	.byte	0x29
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"t"
	.byte	0x2c
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"ix"
	.byte	0x30
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3e4ccccd
	.uleb128 0x1
	.string	"iy"
	.byte	0x31
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3e4ccccd
	.uleb128 0x1
	.string	"iz"
	.byte	0x32
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"ax"
	.byte	0x35
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"ay"
	.byte	0x36
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0
	.uleb128 0x1
	.string	"az"
	.byte	0x37
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"u"
	.byte	0x38
	.byte	0xb
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3e4ccccd
	.uleb128 0x1
	.string	"v"
	.byte	0x38
	.byte	0xe
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3e4ccccd
	.uleb128 0x1
	.string	"w"
	.byte	0x38
	.byte	0x11
	.4byte	0x33b
	.byte	0x4
	.4byte	0x3f800000
	.uleb128 0x1
	.string	"EPS"
	.byte	0x49
	.byte	0x11
	.4byte	0x342
	.byte	0x4
	.4byte	0x358637bd
	.uleb128 0xa
	.4byte	.LASF18
	.byte	0x1
	.byte	0x4e
	.byte	0x9
	.4byte	0x5e
	.byte	0x1
	.uleb128 0xb
	.4byte	.LASF19
	.byte	0x1
	.byte	0x52
	.byte	0x13
	.4byte	0x347
	.4byte	0x20000000
	.uleb128 0xc
	.4byte	0x328
	.uleb128 0xd
	.string	"i"
	.byte	0x1
	.byte	0x21
	.byte	0x12
	.4byte	0x5e
	.byte	0
	.uleb128 0x5
	.4byte	.LVL0
	.4byte	0x85
	.uleb128 0x5
	.4byte	.LVL1
	.4byte	0x7f
	.byte	0
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.4byte	.LASF20
	.uleb128 0xe
	.4byte	0x33b
	.uleb128 0xf
	.byte	0x4
	.4byte	0x65
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	0
	.4byte	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.4byte	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.LLRL0:
	.byte	0x7
	.4byte	.LFB3
	.uleb128 .LFE3-.LFB3
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF19:
	.string	"tohost"
.LASF13:
	.string	"stats"
.LASF16:
	.string	"denom"
.LASF3:
	.string	"unsigned char"
.LASF17:
	.string	"abs_denom"
.LASF7:
	.string	"long unsigned int"
.LASF5:
	.string	"short unsigned int"
.LASF14:
	.string	"init_stats"
.LASF4:
	.string	"short int"
.LASF18:
	.string	"inside"
.LASF10:
	.string	"unsigned int"
.LASF9:
	.string	"long long unsigned int"
.LASF22:
	.string	"main"
.LASF8:
	.string	"long long int"
.LASF15:
	.string	"len_sq"
.LASF21:
	.string	"GNU C17 14.2.0 -mabi=ilp32 -mtune=rocket -misa-spec=20191213 -march=rv32imac_zicsr -g -Os"
.LASF6:
	.string	"long int"
.LASF12:
	.string	"char"
.LASF11:
	.string	"long double"
.LASF20:
	.string	"float"
.LASF2:
	.string	"signed char"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/david/ECE511/final_project/RI5CY/riscv/tb/core"
.LASF0:
	.string	"custom/hello_world.c"
	.ident	"GCC: (g04696df09633) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
