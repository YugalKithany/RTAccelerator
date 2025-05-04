	.file	"hello_world.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_f2p2_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/david/ECE511/final_project/RI5CY/riscv/tb/core" "custom/hello_world.c"
	.align	2
	.globl	main
	.type	main, @function
main:
.LFB3:
	.file 1 "custom/hello_world.c"
	.loc 1 7 12
	.cfi_startproc
	addi	sp,sp,-192
	.cfi_def_cfa_offset 192
	sw	ra,188(sp)
	sw	s0,184(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	addi	s0,sp,192
	.cfi_def_cfa 8, 0
	.loc 1 9 5
	call	init_stats
	.loc 1 12 11
	sw	zero,-40(s0)
	.loc 1 12 23
	sw	zero,-44(s0)
	.loc 1 12 35
	sw	zero,-48(s0)
	.loc 1 13 11
	lui	a5,%hi(.LC0)
	flw	fa5,%lo(.LC0)(a5)
	fsw	fa5,-52(s0)
	.loc 1 13 23
	sw	zero,-56(s0)
	.loc 1 13 35
	sw	zero,-60(s0)
	.loc 1 14 11
	sw	zero,-64(s0)
	.loc 1 14 23
	lui	a5,%hi(.LC0)
	flw	fa5,%lo(.LC0)(a5)
	fsw	fa5,-68(s0)
	.loc 1 14 35
	sw	zero,-72(s0)
	.loc 1 17 11
	lui	a5,%hi(.LC1)
	flw	fa5,%lo(.LC1)(a5)
	fsw	fa5,-76(s0)
	.loc 1 17 22
	lui	a5,%hi(.LC1)
	flw	fa5,%lo(.LC1)(a5)
	fsw	fa5,-80(s0)
	.loc 1 17 33
	lui	a5,%hi(.LC2)
	flw	fa5,%lo(.LC2)(a5)
	fsw	fa5,-84(s0)
	.loc 1 18 11
	sw	zero,-88(s0)
	.loc 1 18 22
	sw	zero,-92(s0)
	.loc 1 18 33
	lui	a5,%hi(.LC0)
	flw	fa5,%lo(.LC0)(a5)
	fsw	fa5,-96(s0)
	.loc 1 21 11
	flw	fa4,-52(s0)
	flw	fa5,-40(s0)
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-100(s0)
	.loc 1 21 28
	flw	fa4,-56(s0)
	flw	fa5,-44(s0)
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-104(s0)
	.loc 1 21 45
	flw	fa4,-60(s0)
	flw	fa5,-48(s0)
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-108(s0)
	.loc 1 22 11
	flw	fa4,-64(s0)
	flw	fa5,-40(s0)
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-112(s0)
	.loc 1 22 28
	flw	fa4,-68(s0)
	flw	fa5,-44(s0)
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-116(s0)
	.loc 1 22 45
	flw	fa4,-72(s0)
	flw	fa5,-48(s0)
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-120(s0)
	.loc 1 25 19
	flw	fa4,-104(s0)
	flw	fa5,-120(s0)
	fmul.s	fa4,fa4,fa5
	.loc 1 25 29
	flw	fa3,-108(s0)
	flw	fa5,-116(s0)
	fmul.s	fa5,fa3,fa5
	.loc 1 25 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-124(s0)
	.loc 1 26 19
	flw	fa4,-108(s0)
	flw	fa5,-112(s0)
	fmul.s	fa4,fa4,fa5
	.loc 1 26 29
	flw	fa3,-100(s0)
	flw	fa5,-120(s0)
	fmul.s	fa5,fa3,fa5
	.loc 1 26 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-128(s0)
	.loc 1 27 19
	flw	fa4,-100(s0)
	flw	fa5,-116(s0)
	fmul.s	fa4,fa4,fa5
	.loc 1 27 29
	flw	fa3,-104(s0)
	flw	fa5,-112(s0)
	fmul.s	fa5,fa3,fa5
	.loc 1 27 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-132(s0)
	.loc 1 30 22
	flw	fa5,-124(s0)
	fmul.s	fa4,fa5,fa5
	.loc 1 30 30
	flw	fa5,-128(s0)
	fmul.s	fa5,fa5,fa5
	.loc 1 30 26
	fadd.s	fa4,fa4,fa5
	.loc 1 30 38
	flw	fa5,-132(s0)
	fmul.s	fa5,fa5,fa5
	.loc 1 30 11
	fadd.s	fa5,fa4,fa5
	fsw	fa5,-136(s0)
	.loc 1 31 11
	flw	fa5,-136(s0)
	fsw	fa5,-20(s0)
	.loc 1 32 8
	flw	fa5,-136(s0)
	fmv.s.x	fa4,zero
	fgt.s	a5,fa5,fa4
	bne	a5,zero,.L35
	j	.L2
.L35:
.LBB2:
	.loc 1 33 18
	sw	zero,-24(s0)
	.loc 1 33 9
	j	.L4
.L5:
	.loc 1 34 39
	flw	fa4,-136(s0)
	flw	fa5,-20(s0)
	fdiv.s	fa4,fa4,fa5
	.loc 1 34 31
	flw	fa5,-20(s0)
	fadd.s	fa4,fa4,fa5
	.loc 1 34 17
	lui	a5,%hi(.LC3)
	flw	fa5,%lo(.LC3)(a5)
	fmul.s	fa5,fa4,fa5
	fsw	fa5,-20(s0)
	.loc 1 33 33 discriminator 3
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L4:
	.loc 1 33 27 discriminator 1
	lw	a4,-24(s0)
	li	a5,3
	ble	a4,a5,.L5
.L2:
.LBE2:
	.loc 1 37 8
	flw	fa4,-124(s0)
	flw	fa5,-20(s0)
	fdiv.s	fa5,fa4,fa5
	fsw	fa5,-124(s0)
	.loc 1 37 19
	flw	fa4,-128(s0)
	flw	fa5,-20(s0)
	fdiv.s	fa5,fa4,fa5
	fsw	fa5,-128(s0)
	.loc 1 37 30
	flw	fa4,-132(s0)
	flw	fa5,-20(s0)
	fdiv.s	fa5,fa4,fa5
	fsw	fa5,-132(s0)
	.loc 1 40 21
	flw	fa4,-88(s0)
	flw	fa5,-124(s0)
	fmul.s	fa4,fa4,fa5
	.loc 1 40 29
	flw	fa3,-92(s0)
	flw	fa5,-128(s0)
	fmul.s	fa5,fa3,fa5
	.loc 1 40 25
	fadd.s	fa4,fa4,fa5
	.loc 1 40 37
	flw	fa3,-96(s0)
	flw	fa5,-132(s0)
	fmul.s	fa5,fa3,fa5
	.loc 1 40 11
	fadd.s	fa5,fa4,fa5
	fsw	fa5,-140(s0)
	.loc 1 41 45
	flw	fa5,-140(s0)
	fmv.s.x	fa4,zero
	flt.s	a5,fa5,fa4
	bne	a5,zero,.L36
	j	.L48
.L36:
	.loc 1 41 45 is_stmt 0 discriminator 1
	flw	fa5,-140(s0)
	fneg.s	fa5,fa5
	j	.L8
.L48:
	.loc 1 41 45 discriminator 2
	flw	fa5,-140(s0)
.L8:
	.loc 1 41 11 is_stmt 1 discriminator 4
	fsw	fa5,-144(s0)
	.loc 1 42 8
	flw	fa4,-144(s0)
	lui	a5,%hi(.LC4)
	flw	fa5,%lo(.LC4)(a5)
	flt.s	a5,fa4,fa5
	bne	a5,zero,.L37
	j	.L49
.L37:
	.loc 1 42 35 discriminator 1
	li	a5,0
	.loc 1 42 35 is_stmt 0
	j	.L11
.L49:
	.loc 1 44 20 is_stmt 1
	flw	fa4,-40(s0)
	flw	fa5,-76(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 44 24
	flw	fa5,-124(s0)
	fmul.s	fa4,fa4,fa5
	.loc 1 44 34
	flw	fa3,-44(s0)
	flw	fa5,-80(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 44 38
	flw	fa5,-128(s0)
	fmul.s	fa5,fa3,fa5
	.loc 1 44 28
	fadd.s	fa4,fa4,fa5
	.loc 1 44 48
	flw	fa3,-48(s0)
	flw	fa5,-84(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 44 52
	flw	fa5,-132(s0)
	fmul.s	fa5,fa3,fa5
	.loc 1 44 42
	fadd.s	fa4,fa4,fa5
	.loc 1 44 11
	flw	fa5,-140(s0)
	fdiv.s	fa5,fa4,fa5
	fsw	fa5,-148(s0)
	.loc 1 45 8
	flw	fa4,-148(s0)
	lui	a5,%hi(.LC5)
	flw	fa5,%lo(.LC5)(a5)
	flt.s	a5,fa4,fa5
	bne	a5,zero,.L38
	j	.L50
.L38:
	.loc 1 45 27 discriminator 1
	li	a5,0
	.loc 1 45 27 is_stmt 0
	j	.L11
.L50:
	.loc 1 48 23 is_stmt 1
	flw	fa4,-88(s0)
	flw	fa5,-148(s0)
	fmul.s	fa5,fa4,fa5
	.loc 1 48 11
	flw	fa4,-76(s0)
	fadd.s	fa5,fa4,fa5
	fsw	fa5,-152(s0)
	.loc 1 49 23
	flw	fa4,-92(s0)
	flw	fa5,-148(s0)
	fmul.s	fa5,fa4,fa5
	.loc 1 49 11
	flw	fa4,-80(s0)
	fadd.s	fa5,fa4,fa5
	fsw	fa5,-156(s0)
	.loc 1 50 23
	flw	fa4,-96(s0)
	flw	fa5,-148(s0)
	fmul.s	fa5,fa4,fa5
	.loc 1 50 11
	flw	fa4,-84(s0)
	fadd.s	fa5,fa4,fa5
	fsw	fa5,-160(s0)
	.loc 1 53 32
	flw	fa5,-124(s0)
	fmv.s.x	fa4,zero
	flt.s	a5,fa5,fa4
	bne	a5,zero,.L39
	j	.L51
.L39:
	.loc 1 53 32 is_stmt 0 discriminator 1
	flw	fa5,-124(s0)
	fneg.s	fa5,fa5
	j	.L16
.L51:
	.loc 1 53 32 discriminator 2
	flw	fa5,-124(s0)
.L16:
	.loc 1 53 11 is_stmt 1 discriminator 4
	fsw	fa5,-164(s0)
	.loc 1 54 32
	flw	fa5,-128(s0)
	fmv.s.x	fa4,zero
	flt.s	a5,fa5,fa4
	bne	a5,zero,.L40
	j	.L52
.L40:
	.loc 1 54 32 is_stmt 0 discriminator 1
	flw	fa5,-128(s0)
	fneg.s	fa5,fa5
	j	.L19
.L52:
	.loc 1 54 32 discriminator 2
	flw	fa5,-128(s0)
.L19:
	.loc 1 54 11 is_stmt 1 discriminator 4
	fsw	fa5,-168(s0)
	.loc 1 55 32
	flw	fa5,-132(s0)
	fmv.s.x	fa4,zero
	flt.s	a5,fa5,fa4
	bne	a5,zero,.L41
	j	.L53
.L41:
	.loc 1 55 32 is_stmt 0 discriminator 1
	flw	fa5,-132(s0)
	fneg.s	fa5,fa5
	j	.L22
.L53:
	.loc 1 55 32 discriminator 2
	flw	fa5,-132(s0)
.L22:
	.loc 1 55 11 is_stmt 1 discriminator 4
	fsw	fa5,-172(s0)
	.loc 1 58 8
	flw	fa4,-164(s0)
	flw	fa5,-168(s0)
	fge.s	a5,fa4,fa5
	bne	a5,zero,.L42
	j	.L23
.L42:
	.loc 1 58 18 discriminator 1
	flw	fa4,-164(s0)
	flw	fa5,-172(s0)
	fge.s	a5,fa4,fa5
	bne	a5,zero,.L43
	j	.L23
.L43:
	.loc 1 59 16
	flw	fa4,-156(s0)
	flw	fa5,-44(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 59 26
	flw	fa3,-72(s0)
	flw	fa5,-48(s0)
	fsub.s	fa5,fa3,fa5
	.loc 1 59 21
	fmul.s	fa4,fa4,fa5
	.loc 1 59 37
	flw	fa3,-160(s0)
	flw	fa5,-48(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 59 47
	flw	fa2,-68(s0)
	flw	fa5,-44(s0)
	fsub.s	fa5,fa2,fa5
	.loc 1 59 42
	fmul.s	fa5,fa3,fa5
	.loc 1 59 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-28(s0)
	.loc 1 60 16
	flw	fa4,-160(s0)
	flw	fa5,-48(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 60 26
	flw	fa3,-56(s0)
	flw	fa5,-44(s0)
	fsub.s	fa5,fa3,fa5
	.loc 1 60 21
	fmul.s	fa4,fa4,fa5
	.loc 1 60 37
	flw	fa3,-156(s0)
	flw	fa5,-44(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 60 47
	flw	fa2,-60(s0)
	flw	fa5,-48(s0)
	fsub.s	fa5,fa2,fa5
	.loc 1 60 42
	fmul.s	fa5,fa3,fa5
	.loc 1 60 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-32(s0)
	.loc 1 61 17
	flw	fa4,-56(s0)
	flw	fa5,-44(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 61 27
	flw	fa3,-72(s0)
	flw	fa5,-48(s0)
	fsub.s	fa5,fa3,fa5
	.loc 1 61 22
	fmul.s	fa4,fa4,fa5
	.loc 1 61 39
	flw	fa3,-60(s0)
	flw	fa5,-48(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 61 49
	flw	fa2,-68(s0)
	flw	fa5,-44(s0)
	fsub.s	fa5,fa2,fa5
	.loc 1 61 44
	fmul.s	fa5,fa3,fa5
	.loc 1 61 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-36(s0)
	j	.L26
.L23:
	.loc 1 62 15
	flw	fa4,-168(s0)
	flw	fa5,-172(s0)
	fge.s	a5,fa4,fa5
	bne	a5,zero,.L44
	j	.L54
.L44:
	.loc 1 63 16
	flw	fa4,-152(s0)
	flw	fa5,-40(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 63 26
	flw	fa3,-72(s0)
	flw	fa5,-48(s0)
	fsub.s	fa5,fa3,fa5
	.loc 1 63 21
	fmul.s	fa4,fa4,fa5
	.loc 1 63 37
	flw	fa3,-160(s0)
	flw	fa5,-48(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 63 47
	flw	fa2,-64(s0)
	flw	fa5,-40(s0)
	fsub.s	fa5,fa2,fa5
	.loc 1 63 42
	fmul.s	fa5,fa3,fa5
	.loc 1 63 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-28(s0)
	.loc 1 64 16
	flw	fa4,-160(s0)
	flw	fa5,-48(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 64 26
	flw	fa3,-52(s0)
	flw	fa5,-40(s0)
	fsub.s	fa5,fa3,fa5
	.loc 1 64 21
	fmul.s	fa4,fa4,fa5
	.loc 1 64 37
	flw	fa3,-152(s0)
	flw	fa5,-40(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 64 47
	flw	fa2,-60(s0)
	flw	fa5,-48(s0)
	fsub.s	fa5,fa2,fa5
	.loc 1 64 42
	fmul.s	fa5,fa3,fa5
	.loc 1 64 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-32(s0)
	.loc 1 65 17
	flw	fa4,-52(s0)
	flw	fa5,-40(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 65 27
	flw	fa3,-72(s0)
	flw	fa5,-48(s0)
	fsub.s	fa5,fa3,fa5
	.loc 1 65 22
	fmul.s	fa4,fa4,fa5
	.loc 1 65 39
	flw	fa3,-60(s0)
	flw	fa5,-48(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 65 49
	flw	fa2,-64(s0)
	flw	fa5,-40(s0)
	fsub.s	fa5,fa2,fa5
	.loc 1 65 44
	fmul.s	fa5,fa3,fa5
	.loc 1 65 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-36(s0)
	j	.L26
.L54:
	.loc 1 67 16
	flw	fa4,-152(s0)
	flw	fa5,-40(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 67 26
	flw	fa3,-68(s0)
	flw	fa5,-44(s0)
	fsub.s	fa5,fa3,fa5
	.loc 1 67 21
	fmul.s	fa4,fa4,fa5
	.loc 1 67 37
	flw	fa3,-156(s0)
	flw	fa5,-44(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 67 47
	flw	fa2,-64(s0)
	flw	fa5,-40(s0)
	fsub.s	fa5,fa2,fa5
	.loc 1 67 42
	fmul.s	fa5,fa3,fa5
	.loc 1 67 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-28(s0)
	.loc 1 68 16
	flw	fa4,-156(s0)
	flw	fa5,-44(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 68 26
	flw	fa3,-52(s0)
	flw	fa5,-40(s0)
	fsub.s	fa5,fa3,fa5
	.loc 1 68 21
	fmul.s	fa4,fa4,fa5
	.loc 1 68 37
	flw	fa3,-152(s0)
	flw	fa5,-40(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 68 47
	flw	fa2,-56(s0)
	flw	fa5,-44(s0)
	fsub.s	fa5,fa2,fa5
	.loc 1 68 42
	fmul.s	fa5,fa3,fa5
	.loc 1 68 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-32(s0)
	.loc 1 69 17
	flw	fa4,-52(s0)
	flw	fa5,-40(s0)
	fsub.s	fa4,fa4,fa5
	.loc 1 69 27
	flw	fa3,-68(s0)
	flw	fa5,-44(s0)
	fsub.s	fa5,fa3,fa5
	.loc 1 69 22
	fmul.s	fa4,fa4,fa5
	.loc 1 69 39
	flw	fa3,-56(s0)
	flw	fa5,-44(s0)
	fsub.s	fa3,fa3,fa5
	.loc 1 69 49
	flw	fa2,-64(s0)
	flw	fa5,-40(s0)
	fsub.s	fa5,fa2,fa5
	.loc 1 69 44
	fmul.s	fa5,fa3,fa5
	.loc 1 69 11
	fsub.s	fa5,fa4,fa5
	fsw	fa5,-36(s0)
.L26:
	.loc 1 73 17
	lui	a5,%hi(.LC5)
	flw	fa5,%lo(.LC5)(a5)
	fsw	fa5,-176(s0)
	.loc 1 74 8
	flw	fa5,-36(s0)
	fmv.s.x	fa4,zero
	feq.s	a5,fa5,fa4
	bne	a5,zero,.L29
	.loc 1 75 11
	flw	fa4,-28(s0)
	flw	fa5,-36(s0)
	fdiv.s	fa5,fa4,fa5
	fsw	fa5,-28(s0)
	.loc 1 76 11
	flw	fa4,-32(s0)
	flw	fa5,-36(s0)
	fdiv.s	fa5,fa4,fa5
	fsw	fa5,-32(s0)
.L29:
	.loc 1 78 24
	flw	fa5,-176(s0)
	fneg.s	fa5,fa5
	.loc 1 78 45
	flw	fa4,-28(s0)
	fge.s	a5,fa4,fa5
	bne	a5,zero,.L45
	j	.L30
.L45:
	.loc 1 78 39 discriminator 1
	flw	fa5,-176(s0)
	fneg.s	fa5,fa5
	.loc 1 78 30 discriminator 1
	flw	fa4,-32(s0)
	fge.s	a5,fa4,fa5
	bne	a5,zero,.L46
	j	.L30
.L46:
	.loc 1 78 50 discriminator 3
	flw	fa4,-28(s0)
	flw	fa5,-32(s0)
	fadd.s	fa4,fa4,fa5
	.loc 1 78 60 discriminator 3
	flw	fa3,-176(s0)
	lui	a5,%hi(.LC0)
	flw	fa5,%lo(.LC0)(a5)
	fadd.s	fa5,fa3,fa5
	.loc 1 78 45 discriminator 3
	fle.s	a5,fa4,fa5
	bne	a5,zero,.L47
	j	.L30
.L47:
	.loc 1 78 45 is_stmt 0 discriminator 5
	li	a5,1
	.loc 1 78 45
	j	.L34
.L30:
	.loc 1 78 45 discriminator 6
	li	a5,0
.L34:
	.loc 1 78 9 is_stmt 1 discriminator 8
	sw	a5,-180(s0)
	.loc 1 80 5
	call	stats
	.loc 1 82 19
	li	a5,536870912
	sw	a5,-184(s0)
	.loc 1 83 13
	lw	a5,-184(s0)
	li	a4,123457536
	addi	a4,a4,-747
	sw	a4,0(a5)
	.loc 1 85 23
	lw	a5,-180(s0)
	snez	a5,a5
	andi	a5,a5,0xff
.L11:
	.loc 1 86 1
	mv	a0,a5
	lw	ra,188(sp)
	.cfi_restore 1
	lw	s0,184(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 192
	addi	sp,sp,192
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.section	.rodata
	.align	2
.LC0:
	.word	1065353216
	.align	2
.LC1:
	.word	1045220557
	.align	2
.LC2:
	.word	-1082130432
	.align	2
.LC3:
	.word	1056964608
	.align	2
.LC4:
	.word	841731191
	.align	2
.LC5:
	.word	897988541
	.text
.Letext0:
	.file 2 "custom/firmware.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x310
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.uleb128 0x5
	.4byte	.LASF21
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
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
	.uleb128 0x6
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x7
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
	.uleb128 0x8
	.4byte	.LASF22
	.byte	0x1
	.byte	0x7
	.byte	0x5
	.4byte	0x5e
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x301
	.uleb128 0x1
	.string	"p0x"
	.byte	0xc
	.byte	0xb
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1
	.string	"p0y"
	.byte	0xc
	.byte	0x17
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x1
	.string	"p0z"
	.byte	0xc
	.byte	0x23
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1
	.string	"p1x"
	.byte	0xd
	.byte	0xb
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x1
	.string	"p1y"
	.byte	0xd
	.byte	0x17
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x1
	.string	"p1z"
	.byte	0xd
	.byte	0x23
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x1
	.string	"p2x"
	.byte	0xe
	.byte	0xb
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1
	.string	"p2y"
	.byte	0xe
	.byte	0x17
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x1
	.string	"p2z"
	.byte	0xe
	.byte	0x23
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x1
	.string	"ex"
	.byte	0x11
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -76
	.uleb128 0x1
	.string	"ey"
	.byte	0x11
	.byte	0x16
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x1
	.string	"ez"
	.byte	0x11
	.byte	0x21
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x1
	.string	"dx"
	.byte	0x12
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x1
	.string	"dy"
	.byte	0x12
	.byte	0x16
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -92
	.uleb128 0x1
	.string	"dz"
	.byte	0x12
	.byte	0x21
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x1
	.string	"e1x"
	.byte	0x15
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -100
	.uleb128 0x1
	.string	"e1y"
	.byte	0x15
	.byte	0x1c
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x1
	.string	"e1z"
	.byte	0x15
	.byte	0x2d
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -108
	.uleb128 0x1
	.string	"e2x"
	.byte	0x16
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x1
	.string	"e2y"
	.byte	0x16
	.byte	0x1c
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -116
	.uleb128 0x1
	.string	"e2z"
	.byte	0x16
	.byte	0x2d
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x1
	.string	"nx"
	.byte	0x19
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -124
	.uleb128 0x1
	.string	"ny"
	.byte	0x1a
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x1
	.string	"nz"
	.byte	0x1b
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -132
	.uleb128 0x3
	.4byte	.LASF15
	.byte	0x1e
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x1
	.string	"len"
	.byte	0x1f
	.byte	0xb
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x3
	.4byte	.LASF16
	.byte	0x28
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -140
	.uleb128 0x3
	.4byte	.LASF17
	.byte	0x29
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.uleb128 0x1
	.string	"t"
	.byte	0x2c
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -148
	.uleb128 0x1
	.string	"ix"
	.byte	0x30
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -152
	.uleb128 0x1
	.string	"iy"
	.byte	0x31
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -156
	.uleb128 0x1
	.string	"iz"
	.byte	0x32
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -160
	.uleb128 0x1
	.string	"ax"
	.byte	0x35
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -164
	.uleb128 0x1
	.string	"ay"
	.byte	0x36
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -168
	.uleb128 0x1
	.string	"az"
	.byte	0x37
	.byte	0xb
	.4byte	0x301
	.uleb128 0x3
	.byte	0x91
	.sleb128 -172
	.uleb128 0x1
	.string	"u"
	.byte	0x38
	.byte	0xb
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1
	.string	"v"
	.byte	0x38
	.byte	0xe
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1
	.string	"w"
	.byte	0x38
	.byte	0x11
	.4byte	0x301
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x1
	.string	"EPS"
	.byte	0x49
	.byte	0x11
	.4byte	0x308
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.uleb128 0x3
	.4byte	.LASF18
	.byte	0x4e
	.byte	0x9
	.4byte	0x5e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -180
	.uleb128 0x3
	.4byte	.LASF19
	.byte	0x52
	.byte	0x13
	.4byte	0x30d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -184
	.uleb128 0x9
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.uleb128 0x1
	.string	"i"
	.byte	0x21
	.byte	0x12
	.4byte	0x5e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.4byte	.LASF20
	.uleb128 0xa
	.4byte	0x301
	.uleb128 0xb
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
	.uleb128 0x2
	.uleb128 0x18
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
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
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
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x6
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
	.uleb128 0x7
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
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
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
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
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF19:
	.string	"tohost"
.LASF13:
	.string	"stats"
.LASF21:
	.string	"GNU C17 14.2.0 -mabi=ilp32 -mtune=rocket -misa-spec=20191213 -march=rv32imf_zicsr -g"
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
