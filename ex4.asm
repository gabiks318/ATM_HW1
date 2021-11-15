.global _start

.section .text
_start:
    xor %rax, %rax # Node Address
    xor %rbx, %rbx # Node value
    xor %rcx, %rcx # New Node value
    xor %r8, %r8
    xor %rdx, %rdx # zero- not existing child to compare
    movq root, %rax
    movq new_node, %rcx
    leaq new_node, %r8
    cmp $0, %rax
    je empty_list
    jmp loop

empty_list:
    movq %r8, root
    jmp end
loop:
    movq (%rax),  %rbx
    cmp %rbx, %rcx
    je end
    cmp %rcx, %rbx
    jg smaller
# case bigger than root
bigger:
    movq 16(%rax), %rdx
    cmp $0, %rdx 
    je bigger_found
    movq %rdx, %rax
    jmp loop
bigger_found:
    movq %r8, 16(%rax)
    jmp end
# case smaller than root
smaller:
    movq 8(%rax), %rdx
    cmp $0, %rdx
    je smaller_found
    movq %rdx, %rax
    jmp loop
smaller_found:
    movq %r8, 8(%rax)
# case exist or placed
end:
