.global _start

.section .text
_start:
#declerations
    movq $BNode, %rax
    xor %rax, %rax      # Current node adress         ????
    xor %rbx, %rbx      # Current node value          ????
    xor %rcx, %rcx      # Source node value           ????
    xor %rdx, %rdx      # Destination node value
    xor %r8, %r8        # Source node adress
    xor %r9, %r9        # Source node found flag
    xor %r10, %r10      # Destination node adress
    xor %r11, %r11      # Destination node index
    xor %r12, %r12      # head adress
    xor %r13, %r13      # one before src
    xor %r14, %r14      # one before dst
    xor %r15, %r15      #father node adress abale
# load values
    movq head, %rax
    leaq head, %r15
    movq %r15, %r12 
    movq (%rax), %rbx
    movq src, %rcx
    movq dst, %rdx
    movq $-1, %r8
    movq $-1, %r10
   
    cmp %rcx, %rdx
    je end
iteration:
    cmp %rbx, %rcx     #cmp current hed to src
    jne dst_check
    movq %rax, %r8     
    movq %r15, %r13
dst_check:
    cmp %rbx, %rdx
    jne finish_loop
    movq %rax, %r10
    movq %r15, %r14
finish_loop:
    movq %rax, %r15         #update current father
    movq 8(%rax), %rax
    cmp $0x00, %rax
    je check_if_found
    movq (%rax), %rbx
 compare:
    cmp $-1, %r10
    je iteration
    cmp $-1, %r8
    je end
check_if_found:
    cmp $-1, %r10
    je end
    cmp $-1, %r8
    je end 
switch_values:
    movq 8(%r10), %rax   # Son of dst
    movq 8(%r8), %rbx    # Son of src
    # Check if dst is after src
    cmp %rbx, %r10
    je dst_after_src
    # Switch src data(father and son)
    movq %rax, 8(%r8)
    movq %r8, 8(%r14)
    # Switch dst data
    movq %rbx, 8(%r10)
    cmp %r12, %r13
    je head_situation
    movq %r10, 8(%r13)
    jmp end
dst_after_src:
    movq %rax, 8(%r8)
    movq %r8, 8(%r10)
    cmp %r12, %r13
    je head_situation
    jmp end
head_situation:
    movq %r10, (%r13)
end:    
