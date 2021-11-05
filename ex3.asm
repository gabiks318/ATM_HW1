.global _start

.section .text
_start:
    xor %rax, %rax
    xor %rbx, %rbx
    xor %rcx, %rcx
    xor %r8, %r8
    movq a, %rax
    movq b, %rbx
    movq %rax, %r8
    movq %rbx, %r9

    # gcd
loop:
    xor %rdx, %rdx    
    mov %rbx, %rcx
    div %rbx
    mov %rcx, %rax
    mov %rdx, %rbx
    cmp $0, %rbx
    jne loop
    movq %rax, %r10
end:
    xor %rdx, %rdx
    movq %r8, %rax
    movq %r9, %rbx
    mul %rbx
    div %r10
    movq %rax, c
