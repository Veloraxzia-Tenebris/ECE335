	.file	"ECE335_HW3.c"
	.text
	.globl	copyij
	.def	copyij;	.scl	2;	.type	32;	.endef
	.seh_proc	copyij
copyij:
	.seh_endprologue
	movq	%rcx, %r11
	movq	%rdx, %r10
	movl	$0, %r9d
	jmp	.L2
.L3:
	movslq	%r9d, %rax
	imulq	$2000, %rax, %rax
	leaq	(%r11,%rax), %r8
	addq	%r10, %rax
	movslq	%edx, %rcx
	movl	(%r8,%rcx,4), %r8d
	movl	%r8d, (%rax,%rcx,4)
	addl	$1, %edx
.L4:
	cmpl	$499, %edx
	jle	.L3
	addl	$1, %r9d
.L2:
	cmpl	$499, %r9d
	jg	.L6
	movl	$0, %edx
	jmp	.L4
.L6:
	ret
	.seh_endproc
	.globl	copyji
	.def	copyji;	.scl	2;	.type	32;	.endef
	.seh_proc	copyji
copyji:
	.seh_endprologue
	movq	%rcx, %r11
	movq	%rdx, %r10
	movl	$0, %r9d
	jmp	.L8
.L9:
	movslq	%edx, %rax
	imulq	$2000, %rax, %rax
	leaq	(%r11,%rax), %r8
	addq	%r10, %rax
	movslq	%r9d, %rcx
	movl	(%r8,%rcx,4), %r8d
	movl	%r8d, (%rax,%rcx,4)
	addl	$1, %edx
.L10:
	cmpl	$499, %edx
	jle	.L9
	addl	$1, %r9d
.L8:
	cmpl	$499, %r9d
	jg	.L12
	movl	$0, %edx
	jmp	.L10
.L12:
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC1:
	.ascii "10000 x ij takes %.2f ms\12\0"
.LC2:
	.ascii "10000 x ji takes %.2f ms\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	movl	$2000032, %eax
	call	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc	2000032
	.seh_endprologue
	call	__main
	call	clock
	movl	%eax, %ecx
	call	srand
	movl	$0, %esi
	jmp	.L14
.L15:
	call	rand
	movl	%eax, %edx
	movslq	%ebx, %rcx
	movslq	%esi, %rax
	imulq	$500, %rax, %rax
	addq	%rcx, %rax
	movl	%edx, 1000032(%rsp,%rax,4)
	addl	$1, %ebx
.L16:
	cmpl	$499, %ebx
	jle	.L15
	addl	$1, %esi
.L14:
	cmpl	$499, %esi
	jg	.L26
	movl	$0, %ebx
	jmp	.L16
.L26:
	movl	$0, %edi
	movl	$0, %ebx
	jmp	.L17
.L18:
	call	clock
	movq	%rax, %rsi
	leaq	32(%rsp), %rdx
	leaq	1000032(%rsp), %rcx
	call	copyij
	call	clock
	subq	%rsi, %rax
	addq	%rax, %rbx
	addl	$1, %edi
.L17:
	cmpl	$9999, %edi
	jle	.L18
	testq	%rbx, %rbx
	js	.L19
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rbx, %xmm0
.L20:
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	mulsd	%xmm0, %xmm1
	movq	%xmm1, %rdx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$0, %edi
	jmp	.L21
.L19:
	movq	%rbx, %rax
	shrq	%rax
	movq	%rbx, %rdx
	andl	$1, %edx
	orq	%rdx, %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm0, %xmm0
	jmp	.L20
.L22:
	call	clock
	movq	%rax, %rsi
	leaq	32(%rsp), %rdx
	leaq	1000032(%rsp), %rcx
	call	copyji
	call	clock
	subq	%rsi, %rax
	addq	%rax, %rbx
	addl	$1, %edi
.L21:
	cmpl	$9999, %edi
	jle	.L22
	testq	%rbx, %rbx
	js	.L23
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rbx, %xmm0
.L24:
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	mulsd	%xmm0, %xmm1
	movq	%xmm1, %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	nop
	addq	$2000032, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L23:
	movq	%rbx, %rax
	shrq	%rax
	andl	$1, %ebx
	orq	%rbx, %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm0, %xmm0
	jmp	.L24
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	0
	.long	1083129856
	.ident	"GCC: (GNU) 11.2.0"
	.def	clock;	.scl	2;	.type	32;	.endef
	.def	srand;	.scl	2;	.type	32;	.endef
	.def	rand;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
