	.file	"ECE335_HW3.c"
	.text
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC2:
	.ascii "10000 x ij takes %.2f ms\12\0"
.LC3:
	.ascii "10000 x ji takes %.2f ms\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movl	$2000080, %eax
	call	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc	2000080
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	call	__main
	movq	$0, 1999944(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, 1999920(%rbp)
	call	clock
	movl	%eax, %ecx
	call	srand
	movl	$0, 1999940(%rbp)
	jmp	.L2
.L5:
	movl	$0, 1999936(%rbp)
	jmp	.L3
.L4:
	call	rand
	movl	1999936(%rbp), %edx
	movslq	%edx, %rcx
	movl	1999940(%rbp), %edx
	movslq	%edx, %rdx
	imulq	$500, %rdx, %rdx
	addq	%rcx, %rdx
	movl	%eax, 999904(%rbp,%rdx,4)
	addl	$1, 1999936(%rbp)
.L3:
	cmpl	$499, 1999936(%rbp)
	jle	.L4
	addl	$1, 1999940(%rbp)
.L2:
	cmpl	$499, 1999940(%rbp)
	jle	.L5
	movl	$0, 1999932(%rbp)
	jmp	.L6
.L7:
	call	clock
	movq	%rax, 1999912(%rbp)
	leaq	-96(%rbp), %rdx
	leaq	999904(%rbp), %rax
	movq	%rax, %rcx
	call	copyij
	call	clock
	subq	1999912(%rbp), %rax
	movq	%rax, 1999912(%rbp)
	movq	1999912(%rbp), %rax
	addq	%rax, 1999944(%rbp)
	addl	$1, 1999932(%rbp)
.L6:
	cmpl	$9999, 1999932(%rbp)
	jle	.L7
	movq	1999944(%rbp), %rax
	testq	%rax, %rax
	js	.L8
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L9
.L8:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L9:
	movsd	.LC1(%rip), %xmm2
	movapd	%xmm0, %xmm1
	divsd	%xmm2, %xmm1
	movsd	.LC1(%rip), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, 1999920(%rbp)
	movsd	1999920(%rbp), %xmm0
	movq	1999920(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC2(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, 1999928(%rbp)
	jmp	.L10
.L11:
	call	clock
	movq	%rax, 1999912(%rbp)
	leaq	-96(%rbp), %rdx
	leaq	999904(%rbp), %rax
	movq	%rax, %rcx
	call	copyji
	call	clock
	subq	1999912(%rbp), %rax
	movq	%rax, 1999912(%rbp)
	movq	1999912(%rbp), %rax
	addq	%rax, 1999944(%rbp)
	addl	$1, 1999928(%rbp)
.L10:
	cmpl	$9999, 1999928(%rbp)
	jle	.L11
	movq	1999944(%rbp), %rax
	testq	%rax, %rax
	js	.L12
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L13
.L12:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L13:
	movsd	.LC1(%rip), %xmm2
	movapd	%xmm0, %xmm1
	divsd	%xmm2, %xmm1
	movsd	.LC1(%rip), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, 1999920(%rbp)
	movsd	1999920(%rbp), %xmm0
	movq	1999920(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC3(%rip), %rax
	movq	%rax, %rcx
	call	printf
	nop
	addq	$2000080, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	copyij
	.def	copyij;	.scl	2;	.type	32;	.endef
	.seh_proc	copyij
copyij:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L16
.L19:
	movl	$0, -8(%rbp)
	jmp	.L17
.L18:
	movl	-4(%rbp), %eax
	cltq
	imulq	$2000, %rax, %rdx
	movq	16(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	imulq	$2000, %rax, %rcx
	movq	24(%rbp), %rax
	addq	%rax, %rcx
	movl	-8(%rbp), %eax
	cltq
	movl	(%rdx,%rax,4), %edx
	movl	-8(%rbp), %eax
	cltq
	movl	%edx, (%rcx,%rax,4)
	addl	$1, -8(%rbp)
.L17:
	cmpl	$499, -8(%rbp)
	jle	.L18
	addl	$1, -4(%rbp)
.L16:
	cmpl	$499, -4(%rbp)
	jle	.L19
	nop
	nop
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	copyji
	.def	copyji;	.scl	2;	.type	32;	.endef
	.seh_proc	copyji
copyji:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L21
.L24:
	movl	$0, -8(%rbp)
	jmp	.L22
.L23:
	movl	-8(%rbp), %eax
	cltq
	imulq	$2000, %rax, %rdx
	movq	16(%rbp), %rax
	addq	%rax, %rdx
	movl	-8(%rbp), %eax
	cltq
	imulq	$2000, %rax, %rcx
	movq	24(%rbp), %rax
	addq	%rax, %rcx
	movl	-4(%rbp), %eax
	cltq
	movl	(%rdx,%rax,4), %edx
	movl	-4(%rbp), %eax
	cltq
	movl	%edx, (%rcx,%rax,4)
	addl	$1, -8(%rbp)
.L22:
	cmpl	$499, -8(%rbp)
	jle	.L23
	addl	$1, -4(%rbp)
.L21:
	cmpl	$499, -4(%rbp)
	jle	.L24
	nop
	nop
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC1:
	.long	0
	.long	1083129856
	.ident	"GCC: (GNU) 11.2.0"
	.def	clock;	.scl	2;	.type	32;	.endef
	.def	srand;	.scl	2;	.type	32;	.endef
	.def	rand;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
