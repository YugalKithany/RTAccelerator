	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C17 (13.2.0-11ubuntu1+12) version 13.2.0 (riscv64-unknown-elf)
#	compiled by GNU C version 13.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mabi=ilp32 -misa-spec=20191213 -march=rv32i -O0 -fno-stack-protector -ffreestanding
	.text
	.globl	__subsf3
	.globl	__mulsf3
	.globl	__addsf3
	.globl	__gtsf2
	.globl	__divsf3
	.globl	__ltsf2
	.globl	__gesf2
	.globl	__nesf2
	.globl	__lesf2
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-192	#,,
	sw	ra,188(sp)	#,
	sw	s0,184(sp)	#,
	sw	s1,180(sp)	#,
	sw	s2,176(sp)	#,
	addi	s0,sp,192	#,,
# main.c:4:     float p0x = 0.0f, p0y = 0.0f, p0z = 0.0f;
	mv	a5,zero	# tmp227,
	sw	a5,-40(s0)	# tmp227, p0x
# main.c:4:     float p0x = 0.0f, p0y = 0.0f, p0z = 0.0f;
	mv	a5,zero	# tmp228,
	sw	a5,-44(s0)	# tmp228, p0y
# main.c:4:     float p0x = 0.0f, p0y = 0.0f, p0z = 0.0f;
	mv	a5,zero	# tmp229,
	sw	a5,-48(s0)	# tmp229, p0z
# main.c:5:     float p1x = 1.0f, p1y = 0.0f, p1z = 0.0f;
	lui	a5,%hi(.LC0)	# tmp230,
	lw	a5,%lo(.LC0)(a5)		# tmp231,
	sw	a5,-52(s0)	# tmp231, p1x
# main.c:5:     float p1x = 1.0f, p1y = 0.0f, p1z = 0.0f;
	mv	a5,zero	# tmp232,
	sw	a5,-56(s0)	# tmp232, p1y
# main.c:5:     float p1x = 1.0f, p1y = 0.0f, p1z = 0.0f;
	mv	a5,zero	# tmp233,
	sw	a5,-60(s0)	# tmp233, p1z
# main.c:6:     float p2x = 0.0f, p2y = 1.0f, p2z = 0.0f;
	mv	a5,zero	# tmp234,
	sw	a5,-64(s0)	# tmp234, p2x
# main.c:6:     float p2x = 0.0f, p2y = 1.0f, p2z = 0.0f;
	lui	a5,%hi(.LC0)	# tmp235,
	lw	a5,%lo(.LC0)(a5)		# tmp236,
	sw	a5,-68(s0)	# tmp236, p2y
# main.c:6:     float p2x = 0.0f, p2y = 1.0f, p2z = 0.0f;
	mv	a5,zero	# tmp237,
	sw	a5,-72(s0)	# tmp237, p2z
# main.c:9:     float ex = 0.2f, ey = 0.2f, ez = -1.0f;
	lui	a5,%hi(.LC1)	# tmp238,
	lw	a5,%lo(.LC1)(a5)		# tmp239,
	sw	a5,-76(s0)	# tmp239, ex
# main.c:9:     float ex = 0.2f, ey = 0.2f, ez = -1.0f;
	lui	a5,%hi(.LC1)	# tmp240,
	lw	a5,%lo(.LC1)(a5)		# tmp241,
	sw	a5,-80(s0)	# tmp241, ey
# main.c:9:     float ex = 0.2f, ey = 0.2f, ez = -1.0f;
	lui	a5,%hi(.LC2)	# tmp242,
	lw	a5,%lo(.LC2)(a5)		# tmp243,
	sw	a5,-84(s0)	# tmp243, ez
# main.c:10:     float dx = 0.0f, dy = 0.0f, dz = 1.0f;
	mv	a5,zero	# tmp244,
	sw	a5,-88(s0)	# tmp244, dx
# main.c:10:     float dx = 0.0f, dy = 0.0f, dz = 1.0f;
	mv	a5,zero	# tmp245,
	sw	a5,-92(s0)	# tmp245, dy
# main.c:10:     float dx = 0.0f, dy = 0.0f, dz = 1.0f;
	lui	a5,%hi(.LC0)	# tmp246,
	lw	a5,%lo(.LC0)(a5)		# tmp247,
	sw	a5,-96(s0)	# tmp247, dz
# main.c:13:     float e1x = p1x - p0x, e1y = p1y - p0y, e1z = p1z - p0z;
	lw	a1,-40(s0)		#, p0x
	lw	a0,-52(s0)		#, p1x
	call	__subsf3		#
	mv	a5,a0	# tmp248,
	sw	a5,-100(s0)	# tmp248, e1x
# main.c:13:     float e1x = p1x - p0x, e1y = p1y - p0y, e1z = p1z - p0z;
	lw	a1,-44(s0)		#, p0y
	lw	a0,-56(s0)		#, p1y
	call	__subsf3		#
	mv	a5,a0	# tmp249,
	sw	a5,-104(s0)	# tmp249, e1y
# main.c:13:     float e1x = p1x - p0x, e1y = p1y - p0y, e1z = p1z - p0z;
	lw	a1,-48(s0)		#, p0z
	lw	a0,-60(s0)		#, p1z
	call	__subsf3		#
	mv	a5,a0	# tmp250,
	sw	a5,-108(s0)	# tmp250, e1z
# main.c:14:     float e2x = p2x - p0x, e2y = p2y - p0y, e2z = p2z - p0z;
	lw	a1,-40(s0)		#, p0x
	lw	a0,-64(s0)		#, p2x
	call	__subsf3		#
	mv	a5,a0	# tmp251,
	sw	a5,-112(s0)	# tmp251, e2x
# main.c:14:     float e2x = p2x - p0x, e2y = p2y - p0y, e2z = p2z - p0z;
	lw	a1,-44(s0)		#, p0y
	lw	a0,-68(s0)		#, p2y
	call	__subsf3		#
	mv	a5,a0	# tmp252,
	sw	a5,-116(s0)	# tmp252, e2y
# main.c:14:     float e2x = p2x - p0x, e2y = p2y - p0y, e2z = p2z - p0z;
	lw	a1,-48(s0)		#, p0z
	lw	a0,-72(s0)		#, p2z
	call	__subsf3		#
	mv	a5,a0	# tmp253,
	sw	a5,-120(s0)	# tmp253, e2z
# main.c:17:     float nx = e1y*e2z - e1z*e2y;
	lw	a1,-120(s0)		#, e2z
	lw	a0,-104(s0)		#, e1y
	call	__mulsf3		#
	mv	a5,a0	# tmp254,
	mv	s1,a5	# _1, tmp254
# main.c:17:     float nx = e1y*e2z - e1z*e2y;
	lw	a1,-116(s0)		#, e2y
	lw	a0,-108(s0)		#, e1z
	call	__mulsf3		#
	mv	a5,a0	# tmp255,
# main.c:17:     float nx = e1y*e2z - e1z*e2y;
	mv	a1,a5	#, _2
	mv	a0,s1	#, _1
	call	__subsf3		#
	mv	a5,a0	# tmp256,
	sw	a5,-124(s0)	# tmp256, nx
# main.c:18:     float ny = e1z*e2x - e1x*e2z;
	lw	a1,-112(s0)		#, e2x
	lw	a0,-108(s0)		#, e1z
	call	__mulsf3		#
	mv	a5,a0	# tmp257,
	mv	s1,a5	# _3, tmp257
# main.c:18:     float ny = e1z*e2x - e1x*e2z;
	lw	a1,-120(s0)		#, e2z
	lw	a0,-100(s0)		#, e1x
	call	__mulsf3		#
	mv	a5,a0	# tmp258,
# main.c:18:     float ny = e1z*e2x - e1x*e2z;
	mv	a1,a5	#, _4
	mv	a0,s1	#, _3
	call	__subsf3		#
	mv	a5,a0	# tmp259,
	sw	a5,-128(s0)	# tmp259, ny
# main.c:19:     float nz = e1x*e2y - e1y*e2x;
	lw	a1,-116(s0)		#, e2y
	lw	a0,-100(s0)		#, e1x
	call	__mulsf3		#
	mv	a5,a0	# tmp260,
	mv	s1,a5	# _5, tmp260
# main.c:19:     float nz = e1x*e2y - e1y*e2x;
	lw	a1,-112(s0)		#, e2x
	lw	a0,-104(s0)		#, e1y
	call	__mulsf3		#
	mv	a5,a0	# tmp261,
# main.c:19:     float nz = e1x*e2y - e1y*e2x;
	mv	a1,a5	#, _6
	mv	a0,s1	#, _5
	call	__subsf3		#
	mv	a5,a0	# tmp262,
	sw	a5,-132(s0)	# tmp262, nz
# main.c:22:     float len_sq = nx*nx + ny*ny + nz*nz;
	lw	a1,-124(s0)		#, nx
	lw	a0,-124(s0)		#, nx
	call	__mulsf3		#
	mv	a5,a0	# tmp263,
	mv	s1,a5	# _7, tmp263
# main.c:22:     float len_sq = nx*nx + ny*ny + nz*nz;
	lw	a1,-128(s0)		#, ny
	lw	a0,-128(s0)		#, ny
	call	__mulsf3		#
	mv	a5,a0	# tmp264,
# main.c:22:     float len_sq = nx*nx + ny*ny + nz*nz;
	mv	a1,a5	#, _8
	mv	a0,s1	#, _7
	call	__addsf3		#
	mv	a5,a0	# tmp265,
	mv	s1,a5	# _9, tmp265
# main.c:22:     float len_sq = nx*nx + ny*ny + nz*nz;
	lw	a1,-132(s0)		#, nz
	lw	a0,-132(s0)		#, nz
	call	__mulsf3		#
	mv	a5,a0	# tmp266,
# main.c:22:     float len_sq = nx*nx + ny*ny + nz*nz;
	mv	a1,a5	#, _10
	mv	a0,s1	#, _9
	call	__addsf3		#
	mv	a5,a0	# tmp267,
	sw	a5,-136(s0)	# tmp267, len_sq
# main.c:23:     float len = len_sq;
	lw	a5,-136(s0)		# tmp268, len_sq
	sw	a5,-20(s0)	# tmp268, len
# main.c:24:     if (len_sq > 0.0f) {
	mv	a1,zero	#,
	lw	a0,-136(s0)		#, len_sq
	call	__gtsf2		#
	mv	a5,a0	# tmp269,
	ble	a5,zero,.L2	#, tmp269,,
# main.c:25:         for (int i = 0; i < 4; i++) {  // 4 iterations for approximation
	sw	zero,-24(s0)	#, i
# main.c:25:         for (int i = 0; i < 4; i++) {  // 4 iterations for approximation
	j	.L4		#
.L5:
# main.c:26:             len = 0.5f * (len + len_sq/len);
	lw	a1,-20(s0)		#, len
	lw	a0,-136(s0)		#, len_sq
	call	__divsf3		#
	mv	a5,a0	# tmp270,
# main.c:26:             len = 0.5f * (len + len_sq/len);
	lw	a1,-20(s0)		#, len
	mv	a0,a5	#, _11
	call	__addsf3		#
	mv	a5,a0	# tmp271,
	mv	a4,a5	# _12, tmp271
# main.c:26:             len = 0.5f * (len + len_sq/len);
	lui	a5,%hi(.LC3)	# tmp272,
	lw	a1,%lo(.LC3)(a5)		#,
	mv	a0,a4	#, _12
	call	__mulsf3		#
	mv	a5,a0	# tmp273,
	sw	a5,-20(s0)	# tmp273, len
# main.c:25:         for (int i = 0; i < 4; i++) {  // 4 iterations for approximation
	lw	a5,-24(s0)		# tmp275, i
	addi	a5,a5,1	#, tmp274, tmp275
	sw	a5,-24(s0)	# tmp274, i
.L4:
# main.c:25:         for (int i = 0; i < 4; i++) {  // 4 iterations for approximation
	lw	a4,-24(s0)		# tmp276, i
	li	a5,3		# tmp277,
	ble	a4,a5,.L5	#, tmp276, tmp277,
.L2:
# main.c:29:     nx /= len; ny /= len; nz /= len;
	lw	a1,-20(s0)		#, len
	lw	a0,-124(s0)		#, nx
	call	__divsf3		#
	mv	a5,a0	# tmp278,
	sw	a5,-124(s0)	# tmp278, nx
# main.c:29:     nx /= len; ny /= len; nz /= len;
	lw	a1,-20(s0)		#, len
	lw	a0,-128(s0)		#, ny
	call	__divsf3		#
	mv	a5,a0	# tmp279,
	sw	a5,-128(s0)	# tmp279, ny
# main.c:29:     nx /= len; ny /= len; nz /= len;
	lw	a1,-20(s0)		#, len
	lw	a0,-132(s0)		#, nz
	call	__divsf3		#
	mv	a5,a0	# tmp280,
	sw	a5,-132(s0)	# tmp280, nz
# main.c:32:     float denom = dx*nx + dy*ny + dz*nz;
	lw	a1,-124(s0)		#, nx
	lw	a0,-88(s0)		#, dx
	call	__mulsf3		#
	mv	a5,a0	# tmp281,
	mv	s1,a5	# _13, tmp281
# main.c:32:     float denom = dx*nx + dy*ny + dz*nz;
	lw	a1,-128(s0)		#, ny
	lw	a0,-92(s0)		#, dy
	call	__mulsf3		#
	mv	a5,a0	# tmp282,
# main.c:32:     float denom = dx*nx + dy*ny + dz*nz;
	mv	a1,a5	#, _14
	mv	a0,s1	#, _13
	call	__addsf3		#
	mv	a5,a0	# tmp283,
	mv	s1,a5	# _15, tmp283
# main.c:32:     float denom = dx*nx + dy*ny + dz*nz;
	lw	a1,-132(s0)		#, nz
	lw	a0,-96(s0)		#, dz
	call	__mulsf3		#
	mv	a5,a0	# tmp284,
# main.c:32:     float denom = dx*nx + dy*ny + dz*nz;
	mv	a1,a5	#, _16
	mv	a0,s1	#, _15
	call	__addsf3		#
	mv	a5,a0	# tmp285,
	sw	a5,-140(s0)	# tmp285, denom
# main.c:33:     float abs_denom = denom < 0.0f ? -denom : denom;
	mv	a1,zero	#,
	lw	a0,-140(s0)		#, denom
	call	__ltsf2		#
	mv	a5,a0	# tmp286,
	bge	a5,zero,.L50	#, tmp286,,
# main.c:33:     float abs_denom = denom < 0.0f ? -denom : denom;
	lw	a4,-140(s0)		# tmp287, denom
	li	a5,-2147483648		# tmp288,
	xor	a5,a4,a5	# tmp288, iftmp.0_95, tmp287
	j	.L8		#
.L50:
# main.c:33:     float abs_denom = denom < 0.0f ? -denom : denom;
	lw	a5,-140(s0)		# iftmp.0_95, denom
.L8:
# main.c:33:     float abs_denom = denom < 0.0f ? -denom : denom;
	sw	a5,-144(s0)	# iftmp.0_95, abs_denom
# main.c:34:     if (abs_denom < 1e-8f) return 0;
	lui	a5,%hi(.LC4)	# tmp289,
	lw	a1,%lo(.LC4)(a5)		#,
	lw	a0,-144(s0)		#, abs_denom
	call	__ltsf2		#
	mv	a5,a0	# tmp290,
	bge	a5,zero,.L51	#, tmp290,,
# main.c:34:     if (abs_denom < 1e-8f) return 0;
	li	a5,0		# _96,
# main.c:34:     if (abs_denom < 1e-8f) return 0;
	j	.L11		#
.L51:
# main.c:36:     float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
	lw	a1,-76(s0)		#, ex
	lw	a0,-40(s0)		#, p0x
	call	__subsf3		#
	mv	a5,a0	# tmp291,
# main.c:36:     float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
	lw	a1,-124(s0)		#, nx
	mv	a0,a5	#, _17
	call	__mulsf3		#
	mv	a5,a0	# tmp292,
	mv	s1,a5	# _18, tmp292
# main.c:36:     float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
	lw	a1,-80(s0)		#, ey
	lw	a0,-44(s0)		#, p0y
	call	__subsf3		#
	mv	a5,a0	# tmp293,
# main.c:36:     float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
	lw	a1,-128(s0)		#, ny
	mv	a0,a5	#, _19
	call	__mulsf3		#
	mv	a5,a0	# tmp294,
# main.c:36:     float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
	mv	a1,a5	#, _20
	mv	a0,s1	#, _18
	call	__addsf3		#
	mv	a5,a0	# tmp295,
	mv	s1,a5	# _21, tmp295
# main.c:36:     float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
	lw	a1,-84(s0)		#, ez
	lw	a0,-48(s0)		#, p0z
	call	__subsf3		#
	mv	a5,a0	# tmp296,
# main.c:36:     float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
	lw	a1,-132(s0)		#, nz
	mv	a0,a5	#, _22
	call	__mulsf3		#
	mv	a5,a0	# tmp297,
# main.c:36:     float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
	mv	a1,a5	#, _23
	mv	a0,s1	#, _21
	call	__addsf3		#
	mv	a5,a0	# tmp298,
# main.c:36:     float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
	lw	a1,-140(s0)		#, denom
	mv	a0,a5	#, _24
	call	__divsf3		#
	mv	a5,a0	# tmp299,
	sw	a5,-148(s0)	# tmp299, t
# main.c:37:     if (t < 1e-6f) return 0;
	lui	a5,%hi(.LC5)	# tmp300,
	lw	a1,%lo(.LC5)(a5)		#,
	lw	a0,-148(s0)		#, t
	call	__ltsf2		#
	mv	a5,a0	# tmp301,
	bge	a5,zero,.L52	#, tmp301,,
# main.c:37:     if (t < 1e-6f) return 0;
	li	a5,0		# _96,
# main.c:37:     if (t < 1e-6f) return 0;
	j	.L11		#
.L52:
# main.c:40:     float ix = ex + dx*t;
	lw	a1,-148(s0)		#, t
	lw	a0,-88(s0)		#, dx
	call	__mulsf3		#
	mv	a5,a0	# tmp302,
# main.c:40:     float ix = ex + dx*t;
	mv	a1,a5	#, _25
	lw	a0,-76(s0)		#, ex
	call	__addsf3		#
	mv	a5,a0	# tmp303,
	sw	a5,-152(s0)	# tmp303, ix
# main.c:41:     float iy = ey + dy*t;
	lw	a1,-148(s0)		#, t
	lw	a0,-92(s0)		#, dy
	call	__mulsf3		#
	mv	a5,a0	# tmp304,
# main.c:41:     float iy = ey + dy*t;
	mv	a1,a5	#, _26
	lw	a0,-80(s0)		#, ey
	call	__addsf3		#
	mv	a5,a0	# tmp305,
	sw	a5,-156(s0)	# tmp305, iy
# main.c:42:     float iz = ez + dz*t;
	lw	a1,-148(s0)		#, t
	lw	a0,-96(s0)		#, dz
	call	__mulsf3		#
	mv	a5,a0	# tmp306,
# main.c:42:     float iz = ez + dz*t;
	mv	a1,a5	#, _27
	lw	a0,-84(s0)		#, ez
	call	__addsf3		#
	mv	a5,a0	# tmp307,
	sw	a5,-160(s0)	# tmp307, iz
# main.c:45:     float ax = nx < 0.0f ? -nx : nx;
	mv	a1,zero	#,
	lw	a0,-124(s0)		#, nx
	call	__ltsf2		#
	mv	a5,a0	# tmp308,
	bge	a5,zero,.L53	#, tmp308,,
# main.c:45:     float ax = nx < 0.0f ? -nx : nx;
	lw	a4,-124(s0)		# tmp309, nx
	li	a5,-2147483648		# tmp310,
	xor	a5,a4,a5	# tmp310, iftmp.1_97, tmp309
	j	.L16		#
.L53:
# main.c:45:     float ax = nx < 0.0f ? -nx : nx;
	lw	a5,-124(s0)		# iftmp.1_97, nx
.L16:
# main.c:45:     float ax = nx < 0.0f ? -nx : nx;
	sw	a5,-164(s0)	# iftmp.1_97, ax
# main.c:46:     float ay = ny < 0.0f ? -ny : ny;
	mv	a1,zero	#,
	lw	a0,-128(s0)		#, ny
	call	__ltsf2		#
	mv	a5,a0	# tmp311,
	bge	a5,zero,.L54	#, tmp311,,
# main.c:46:     float ay = ny < 0.0f ? -ny : ny;
	lw	a4,-128(s0)		# tmp312, ny
	li	a5,-2147483648		# tmp313,
	xor	a5,a4,a5	# tmp313, iftmp.2_98, tmp312
	j	.L19		#
.L54:
# main.c:46:     float ay = ny < 0.0f ? -ny : ny;
	lw	a5,-128(s0)		# iftmp.2_98, ny
.L19:
# main.c:46:     float ay = ny < 0.0f ? -ny : ny;
	sw	a5,-168(s0)	# iftmp.2_98, ay
# main.c:47:     float az = nz < 0.0f ? -nz : nz;
	mv	a1,zero	#,
	lw	a0,-132(s0)		#, nz
	call	__ltsf2		#
	mv	a5,a0	# tmp314,
	bge	a5,zero,.L55	#, tmp314,,
# main.c:47:     float az = nz < 0.0f ? -nz : nz;
	lw	a4,-132(s0)		# tmp315, nz
	li	a5,-2147483648		# tmp316,
	xor	a5,a4,a5	# tmp316, iftmp.3_99, tmp315
	j	.L22		#
.L55:
# main.c:47:     float az = nz < 0.0f ? -nz : nz;
	lw	a5,-132(s0)		# iftmp.3_99, nz
.L22:
# main.c:47:     float az = nz < 0.0f ? -nz : nz;
	sw	a5,-172(s0)	# iftmp.3_99, az
# main.c:50:     if (ax >= ay && ax >= az) {  // Project to YZ
	lw	a1,-168(s0)		#, ay
	lw	a0,-164(s0)		#, ax
	call	__gesf2		#
	mv	a5,a0	# tmp317,
	blt	a5,zero,.L23	#, tmp317,,
# main.c:50:     if (ax >= ay && ax >= az) {  // Project to YZ
	lw	a1,-172(s0)		#, az
	lw	a0,-164(s0)		#, ax
	call	__gesf2		#
	mv	a5,a0	# tmp318,
	blt	a5,zero,.L23	#, tmp318,,
# main.c:51:         u = (iy-p0y)*(p2z-p0z) - (iz-p0z)*(p2y-p0y);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-156(s0)		#, iy
	call	__subsf3		#
	mv	a5,a0	# tmp319,
	mv	s1,a5	# _28, tmp319
# main.c:51:         u = (iy-p0y)*(p2z-p0z) - (iz-p0z)*(p2y-p0y);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-72(s0)		#, p2z
	call	__subsf3		#
	mv	a5,a0	# tmp320,
# main.c:51:         u = (iy-p0y)*(p2z-p0z) - (iz-p0z)*(p2y-p0y);
	mv	a1,a5	#, _29
	mv	a0,s1	#, _28
	call	__mulsf3		#
	mv	a5,a0	# tmp321,
	mv	s1,a5	# _30, tmp321
# main.c:51:         u = (iy-p0y)*(p2z-p0z) - (iz-p0z)*(p2y-p0y);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-160(s0)		#, iz
	call	__subsf3		#
	mv	a5,a0	# tmp322,
	mv	s2,a5	# _31, tmp322
# main.c:51:         u = (iy-p0y)*(p2z-p0z) - (iz-p0z)*(p2y-p0y);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-68(s0)		#, p2y
	call	__subsf3		#
	mv	a5,a0	# tmp323,
# main.c:51:         u = (iy-p0y)*(p2z-p0z) - (iz-p0z)*(p2y-p0y);
	mv	a1,a5	#, _32
	mv	a0,s2	#, _31
	call	__mulsf3		#
	mv	a5,a0	# tmp324,
# main.c:51:         u = (iy-p0y)*(p2z-p0z) - (iz-p0z)*(p2y-p0y);
	mv	a1,a5	#, _33
	mv	a0,s1	#, _30
	call	__subsf3		#
	mv	a5,a0	# tmp325,
	sw	a5,-28(s0)	# tmp325, u
# main.c:52:         v = (iz-p0z)*(p1y-p0y) - (iy-p0y)*(p1z-p0z);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-160(s0)		#, iz
	call	__subsf3		#
	mv	a5,a0	# tmp326,
	mv	s1,a5	# _34, tmp326
# main.c:52:         v = (iz-p0z)*(p1y-p0y) - (iy-p0y)*(p1z-p0z);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-56(s0)		#, p1y
	call	__subsf3		#
	mv	a5,a0	# tmp327,
# main.c:52:         v = (iz-p0z)*(p1y-p0y) - (iy-p0y)*(p1z-p0z);
	mv	a1,a5	#, _35
	mv	a0,s1	#, _34
	call	__mulsf3		#
	mv	a5,a0	# tmp328,
	mv	s1,a5	# _36, tmp328
# main.c:52:         v = (iz-p0z)*(p1y-p0y) - (iy-p0y)*(p1z-p0z);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-156(s0)		#, iy
	call	__subsf3		#
	mv	a5,a0	# tmp329,
	mv	s2,a5	# _37, tmp329
# main.c:52:         v = (iz-p0z)*(p1y-p0y) - (iy-p0y)*(p1z-p0z);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-60(s0)		#, p1z
	call	__subsf3		#
	mv	a5,a0	# tmp330,
# main.c:52:         v = (iz-p0z)*(p1y-p0y) - (iy-p0y)*(p1z-p0z);
	mv	a1,a5	#, _38
	mv	a0,s2	#, _37
	call	__mulsf3		#
	mv	a5,a0	# tmp331,
# main.c:52:         v = (iz-p0z)*(p1y-p0y) - (iy-p0y)*(p1z-p0z);
	mv	a1,a5	#, _39
	mv	a0,s1	#, _36
	call	__subsf3		#
	mv	a5,a0	# tmp332,
	sw	a5,-32(s0)	# tmp332, v
# main.c:53:         w = (p1y-p0y)*(p2z-p0z) - (p1z-p0z)*(p2y-p0y);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-56(s0)		#, p1y
	call	__subsf3		#
	mv	a5,a0	# tmp333,
	mv	s1,a5	# _40, tmp333
# main.c:53:         w = (p1y-p0y)*(p2z-p0z) - (p1z-p0z)*(p2y-p0y);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-72(s0)		#, p2z
	call	__subsf3		#
	mv	a5,a0	# tmp334,
# main.c:53:         w = (p1y-p0y)*(p2z-p0z) - (p1z-p0z)*(p2y-p0y);
	mv	a1,a5	#, _41
	mv	a0,s1	#, _40
	call	__mulsf3		#
	mv	a5,a0	# tmp335,
	mv	s1,a5	# _42, tmp335
# main.c:53:         w = (p1y-p0y)*(p2z-p0z) - (p1z-p0z)*(p2y-p0y);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-60(s0)		#, p1z
	call	__subsf3		#
	mv	a5,a0	# tmp336,
	mv	s2,a5	# _43, tmp336
# main.c:53:         w = (p1y-p0y)*(p2z-p0z) - (p1z-p0z)*(p2y-p0y);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-68(s0)		#, p2y
	call	__subsf3		#
	mv	a5,a0	# tmp337,
# main.c:53:         w = (p1y-p0y)*(p2z-p0z) - (p1z-p0z)*(p2y-p0y);
	mv	a1,a5	#, _44
	mv	a0,s2	#, _43
	call	__mulsf3		#
	mv	a5,a0	# tmp338,
# main.c:53:         w = (p1y-p0y)*(p2z-p0z) - (p1z-p0z)*(p2y-p0y);
	mv	a1,a5	#, _45
	mv	a0,s1	#, _42
	call	__subsf3		#
	mv	a5,a0	# tmp339,
	sw	a5,-36(s0)	# tmp339, w
	j	.L26		#
.L23:
# main.c:54:     } else if (ay >= az) {       // Project to XZ
	lw	a1,-172(s0)		#, az
	lw	a0,-168(s0)		#, ay
	call	__gesf2		#
	mv	a5,a0	# tmp340,
	blt	a5,zero,.L56	#, tmp340,,
# main.c:55:         u = (ix-p0x)*(p2z-p0z) - (iz-p0z)*(p2x-p0x);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-152(s0)		#, ix
	call	__subsf3		#
	mv	a5,a0	# tmp341,
	mv	s1,a5	# _46, tmp341
# main.c:55:         u = (ix-p0x)*(p2z-p0z) - (iz-p0z)*(p2x-p0x);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-72(s0)		#, p2z
	call	__subsf3		#
	mv	a5,a0	# tmp342,
# main.c:55:         u = (ix-p0x)*(p2z-p0z) - (iz-p0z)*(p2x-p0x);
	mv	a1,a5	#, _47
	mv	a0,s1	#, _46
	call	__mulsf3		#
	mv	a5,a0	# tmp343,
	mv	s1,a5	# _48, tmp343
# main.c:55:         u = (ix-p0x)*(p2z-p0z) - (iz-p0z)*(p2x-p0x);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-160(s0)		#, iz
	call	__subsf3		#
	mv	a5,a0	# tmp344,
	mv	s2,a5	# _49, tmp344
# main.c:55:         u = (ix-p0x)*(p2z-p0z) - (iz-p0z)*(p2x-p0x);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-64(s0)		#, p2x
	call	__subsf3		#
	mv	a5,a0	# tmp345,
# main.c:55:         u = (ix-p0x)*(p2z-p0z) - (iz-p0z)*(p2x-p0x);
	mv	a1,a5	#, _50
	mv	a0,s2	#, _49
	call	__mulsf3		#
	mv	a5,a0	# tmp346,
# main.c:55:         u = (ix-p0x)*(p2z-p0z) - (iz-p0z)*(p2x-p0x);
	mv	a1,a5	#, _51
	mv	a0,s1	#, _48
	call	__subsf3		#
	mv	a5,a0	# tmp347,
	sw	a5,-28(s0)	# tmp347, u
# main.c:56:         v = (iz-p0z)*(p1x-p0x) - (ix-p0x)*(p1z-p0z);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-160(s0)		#, iz
	call	__subsf3		#
	mv	a5,a0	# tmp348,
	mv	s1,a5	# _52, tmp348
# main.c:56:         v = (iz-p0z)*(p1x-p0x) - (ix-p0x)*(p1z-p0z);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-52(s0)		#, p1x
	call	__subsf3		#
	mv	a5,a0	# tmp349,
# main.c:56:         v = (iz-p0z)*(p1x-p0x) - (ix-p0x)*(p1z-p0z);
	mv	a1,a5	#, _53
	mv	a0,s1	#, _52
	call	__mulsf3		#
	mv	a5,a0	# tmp350,
	mv	s1,a5	# _54, tmp350
# main.c:56:         v = (iz-p0z)*(p1x-p0x) - (ix-p0x)*(p1z-p0z);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-152(s0)		#, ix
	call	__subsf3		#
	mv	a5,a0	# tmp351,
	mv	s2,a5	# _55, tmp351
# main.c:56:         v = (iz-p0z)*(p1x-p0x) - (ix-p0x)*(p1z-p0z);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-60(s0)		#, p1z
	call	__subsf3		#
	mv	a5,a0	# tmp352,
# main.c:56:         v = (iz-p0z)*(p1x-p0x) - (ix-p0x)*(p1z-p0z);
	mv	a1,a5	#, _56
	mv	a0,s2	#, _55
	call	__mulsf3		#
	mv	a5,a0	# tmp353,
# main.c:56:         v = (iz-p0z)*(p1x-p0x) - (ix-p0x)*(p1z-p0z);
	mv	a1,a5	#, _57
	mv	a0,s1	#, _54
	call	__subsf3		#
	mv	a5,a0	# tmp354,
	sw	a5,-32(s0)	# tmp354, v
# main.c:57:         w = (p1x-p0x)*(p2z-p0z) - (p1z-p0z)*(p2x-p0x);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-52(s0)		#, p1x
	call	__subsf3		#
	mv	a5,a0	# tmp355,
	mv	s1,a5	# _58, tmp355
# main.c:57:         w = (p1x-p0x)*(p2z-p0z) - (p1z-p0z)*(p2x-p0x);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-72(s0)		#, p2z
	call	__subsf3		#
	mv	a5,a0	# tmp356,
# main.c:57:         w = (p1x-p0x)*(p2z-p0z) - (p1z-p0z)*(p2x-p0x);
	mv	a1,a5	#, _59
	mv	a0,s1	#, _58
	call	__mulsf3		#
	mv	a5,a0	# tmp357,
	mv	s1,a5	# _60, tmp357
# main.c:57:         w = (p1x-p0x)*(p2z-p0z) - (p1z-p0z)*(p2x-p0x);
	lw	a1,-48(s0)		#, p0z
	lw	a0,-60(s0)		#, p1z
	call	__subsf3		#
	mv	a5,a0	# tmp358,
	mv	s2,a5	# _61, tmp358
# main.c:57:         w = (p1x-p0x)*(p2z-p0z) - (p1z-p0z)*(p2x-p0x);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-64(s0)		#, p2x
	call	__subsf3		#
	mv	a5,a0	# tmp359,
# main.c:57:         w = (p1x-p0x)*(p2z-p0z) - (p1z-p0z)*(p2x-p0x);
	mv	a1,a5	#, _62
	mv	a0,s2	#, _61
	call	__mulsf3		#
	mv	a5,a0	# tmp360,
# main.c:57:         w = (p1x-p0x)*(p2z-p0z) - (p1z-p0z)*(p2x-p0x);
	mv	a1,a5	#, _63
	mv	a0,s1	#, _60
	call	__subsf3		#
	mv	a5,a0	# tmp361,
	sw	a5,-36(s0)	# tmp361, w
	j	.L26		#
.L56:
# main.c:59:         u = (ix-p0x)*(p2y-p0y) - (iy-p0y)*(p2x-p0x);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-152(s0)		#, ix
	call	__subsf3		#
	mv	a5,a0	# tmp362,
	mv	s1,a5	# _64, tmp362
# main.c:59:         u = (ix-p0x)*(p2y-p0y) - (iy-p0y)*(p2x-p0x);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-68(s0)		#, p2y
	call	__subsf3		#
	mv	a5,a0	# tmp363,
# main.c:59:         u = (ix-p0x)*(p2y-p0y) - (iy-p0y)*(p2x-p0x);
	mv	a1,a5	#, _65
	mv	a0,s1	#, _64
	call	__mulsf3		#
	mv	a5,a0	# tmp364,
	mv	s1,a5	# _66, tmp364
# main.c:59:         u = (ix-p0x)*(p2y-p0y) - (iy-p0y)*(p2x-p0x);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-156(s0)		#, iy
	call	__subsf3		#
	mv	a5,a0	# tmp365,
	mv	s2,a5	# _67, tmp365
# main.c:59:         u = (ix-p0x)*(p2y-p0y) - (iy-p0y)*(p2x-p0x);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-64(s0)		#, p2x
	call	__subsf3		#
	mv	a5,a0	# tmp366,
# main.c:59:         u = (ix-p0x)*(p2y-p0y) - (iy-p0y)*(p2x-p0x);
	mv	a1,a5	#, _68
	mv	a0,s2	#, _67
	call	__mulsf3		#
	mv	a5,a0	# tmp367,
# main.c:59:         u = (ix-p0x)*(p2y-p0y) - (iy-p0y)*(p2x-p0x);
	mv	a1,a5	#, _69
	mv	a0,s1	#, _66
	call	__subsf3		#
	mv	a5,a0	# tmp368,
	sw	a5,-28(s0)	# tmp368, u
# main.c:60:         v = (iy-p0y)*(p1x-p0x) - (ix-p0x)*(p1y-p0y);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-156(s0)		#, iy
	call	__subsf3		#
	mv	a5,a0	# tmp369,
	mv	s1,a5	# _70, tmp369
# main.c:60:         v = (iy-p0y)*(p1x-p0x) - (ix-p0x)*(p1y-p0y);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-52(s0)		#, p1x
	call	__subsf3		#
	mv	a5,a0	# tmp370,
# main.c:60:         v = (iy-p0y)*(p1x-p0x) - (ix-p0x)*(p1y-p0y);
	mv	a1,a5	#, _71
	mv	a0,s1	#, _70
	call	__mulsf3		#
	mv	a5,a0	# tmp371,
	mv	s1,a5	# _72, tmp371
# main.c:60:         v = (iy-p0y)*(p1x-p0x) - (ix-p0x)*(p1y-p0y);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-152(s0)		#, ix
	call	__subsf3		#
	mv	a5,a0	# tmp372,
	mv	s2,a5	# _73, tmp372
# main.c:60:         v = (iy-p0y)*(p1x-p0x) - (ix-p0x)*(p1y-p0y);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-56(s0)		#, p1y
	call	__subsf3		#
	mv	a5,a0	# tmp373,
# main.c:60:         v = (iy-p0y)*(p1x-p0x) - (ix-p0x)*(p1y-p0y);
	mv	a1,a5	#, _74
	mv	a0,s2	#, _73
	call	__mulsf3		#
	mv	a5,a0	# tmp374,
# main.c:60:         v = (iy-p0y)*(p1x-p0x) - (ix-p0x)*(p1y-p0y);
	mv	a1,a5	#, _75
	mv	a0,s1	#, _72
	call	__subsf3		#
	mv	a5,a0	# tmp375,
	sw	a5,-32(s0)	# tmp375, v
# main.c:61:         w = (p1x-p0x)*(p2y-p0y) - (p1y-p0y)*(p2x-p0x);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-52(s0)		#, p1x
	call	__subsf3		#
	mv	a5,a0	# tmp376,
	mv	s1,a5	# _76, tmp376
# main.c:61:         w = (p1x-p0x)*(p2y-p0y) - (p1y-p0y)*(p2x-p0x);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-68(s0)		#, p2y
	call	__subsf3		#
	mv	a5,a0	# tmp377,
# main.c:61:         w = (p1x-p0x)*(p2y-p0y) - (p1y-p0y)*(p2x-p0x);
	mv	a1,a5	#, _77
	mv	a0,s1	#, _76
	call	__mulsf3		#
	mv	a5,a0	# tmp378,
	mv	s1,a5	# _78, tmp378
# main.c:61:         w = (p1x-p0x)*(p2y-p0y) - (p1y-p0y)*(p2x-p0x);
	lw	a1,-44(s0)		#, p0y
	lw	a0,-56(s0)		#, p1y
	call	__subsf3		#
	mv	a5,a0	# tmp379,
	mv	s2,a5	# _79, tmp379
# main.c:61:         w = (p1x-p0x)*(p2y-p0y) - (p1y-p0y)*(p2x-p0x);
	lw	a1,-40(s0)		#, p0x
	lw	a0,-64(s0)		#, p2x
	call	__subsf3		#
	mv	a5,a0	# tmp380,
# main.c:61:         w = (p1x-p0x)*(p2y-p0y) - (p1y-p0y)*(p2x-p0x);
	mv	a1,a5	#, _80
	mv	a0,s2	#, _79
	call	__mulsf3		#
	mv	a5,a0	# tmp381,
# main.c:61:         w = (p1x-p0x)*(p2y-p0y) - (p1y-p0y)*(p2x-p0x);
	mv	a1,a5	#, _81
	mv	a0,s1	#, _78
	call	__subsf3		#
	mv	a5,a0	# tmp382,
	sw	a5,-36(s0)	# tmp382, w
.L26:
# main.c:65:     const float EPS = 1e-6f;
	lui	a5,%hi(.LC5)	# tmp383,
	lw	a5,%lo(.LC5)(a5)		# tmp384,
	sw	a5,-176(s0)	# tmp384, EPS
# main.c:66:     if (w != 0.0f) {
	mv	a1,zero	#,
	lw	a0,-36(s0)		#, w
	call	__nesf2		#
	mv	a5,a0	# tmp385,
	beq	a5,zero,.L29	#, tmp385,,
# main.c:67:         u /= w;
	lw	a1,-36(s0)		#, w
	lw	a0,-28(s0)		#, u
	call	__divsf3		#
	mv	a5,a0	# tmp386,
	sw	a5,-28(s0)	# tmp386, u
# main.c:68:         v /= w;
	lw	a1,-36(s0)		#, w
	lw	a0,-32(s0)		#, v
	call	__divsf3		#
	mv	a5,a0	# tmp387,
	sw	a5,-32(s0)	# tmp387, v
.L29:
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	lw	a4,-176(s0)		# tmp388, EPS
	li	a5,-2147483648		# tmp389,
	xor	a5,a4,a5	# tmp389, _82, tmp388
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	mv	a1,a5	#, _82
	lw	a0,-28(s0)		#, u
	call	__gesf2		#
	mv	a5,a0	# tmp390,
	blt	a5,zero,.L31	#, tmp390,,
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	lw	a4,-176(s0)		# tmp391, EPS
	li	a5,-2147483648		# tmp392,
	xor	a5,a4,a5	# tmp392, _83, tmp391
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	mv	a1,a5	#, _83
	lw	a0,-32(s0)		#, v
	call	__gesf2		#
	mv	a5,a0	# tmp393,
	blt	a5,zero,.L31	#, tmp393,,
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	lw	a1,-32(s0)		#, v
	lw	a0,-28(s0)		#, u
	call	__addsf3		#
	mv	a5,a0	# tmp394,
	mv	s1,a5	# _84, tmp394
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	lui	a5,%hi(.LC0)	# tmp395,
	lw	a1,%lo(.LC0)(a5)		#,
	lw	a0,-176(s0)		#, EPS
	call	__addsf3		#
	mv	a5,a0	# tmp396,
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	mv	a1,a5	#, _85
	mv	a0,s1	#, _84
	call	__lesf2		#
	mv	a5,a0	# tmp397,
	bgt	a5,zero,.L31	#, tmp397,,
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	li	a5,1		# iftmp.4_100,
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	j	.L35		#
.L31:
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	li	a5,0		# iftmp.4_100,
.L35:
# main.c:70:     int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);
	sw	a5,-180(s0)	# iftmp.4_100, inside
# main.c:72:     return inside ? 1 : 0;  // Return 1 if intersection, 0 otherwise
	lw	a5,-180(s0)		# tmp399, inside
	snez	a5,a5	# tmp400, tmp399
	andi	a5,a5,0xff	# _86, tmp398
.L11:
# main.c:73: }
	mv	a0,a5	#, <retval>
	lw	ra,188(sp)		#,
	lw	s0,184(sp)		#,
	lw	s1,180(sp)		#,
	lw	s2,176(sp)		#,
	addi	sp,sp,192	#,,
	jr	ra		#
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
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
