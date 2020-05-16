	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"dist.c"
	.text
	.align	2
	.global	measure
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	measure, %function
measure:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	mov	r1, #0
	mov	r0, #23
	bl	digitalWrite
	vldr.64	d0, .L7
	bl	sleep
	mov	r1, #0
	mov	r0, #23
	bl	digitalWrite
	b	.L2
.L3:
	mov	r0, #0
	bl	time
	str	r0, [fp, #-8]
.L2:
	mov	r0, #24
	bl	digitalRead
	mov	r3, r0
	cmp	r3, #0
	beq	.L3
	b	.L4
.L5:
	mov	r0, #0
	bl	time
	str	r0, [fp, #-12]
.L4:
	mov	r0, #24
	bl	digitalRead
	mov	r3, r0
	cmp	r3, #1
	beq	.L5
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-8]
	sub	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	mov	r3, r2
	lsl	r3, r3, #5
	add	r3, r3, r2
	lsl	r3, r3, #1
	add	r3, r3, r2
	lsl	r3, r3, #7
	sub	r3, r3, r2
	lsl	r3, r3, #1
	vmov	s15, r3	@ int
	vcvt.f64.s32	d7, s15
	vstr.64	d7, [fp, #-28]
	ldrd	r2, [fp, #-28]
	vmov	d7, r2, r3
	vmov.f64	d0, d7
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L8:
	.align	3
.L7:
	.word	-1998362383
	.word	1055193269
	.size	measure, .-measure
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Distance: %.1f cm.\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	bl	wiringPiSetup
	bl	wiringPiSetupGpio
	mov	r1, #1
	mov	r0, #23
	bl	pinMode
	mov	r1, #0
	mov	r0, #24
	bl	pinMode
	mov	r1, #0
	mov	r0, #23
	bl	digitalWrite
.L10:
	bl	measure
	vstr.64	d0, [fp, #-12]
	ldrd	r2, [fp, #-12]
	ldr	r0, .L11
	bl	printf
	b	.L10
.L12:
	.align	2
.L11:
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
