	.file	"ECE335_HW2.c"
	.text
	.globl	loop
	.def	loop;	.scl	2;	.type	32;	.endef
	.seh_proc	loop
loop:
	.seh_endprologue
	movq	%rcx, %r10
	movq	%rdx, %rcx
	movl	$1, %eax
	movl	$0, %r8d
	jmp	.L2
.L3:
	movq	%rax, %r9
	andq	%r10, %r9
	orq	%r9, %r8
	salq	%cl, %rax
.L2:
	testq	%rax, %rax
	jne	.L3
	movq	%r8, %rax
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$2, %edx
	movl	$8, %ecx
	call	loop
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.ident	"GCC: (GNU) 11.2.0"
