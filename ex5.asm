.global _start

.section .text
_start:
#declerations
    # movq $BNode, %rax
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
    cmp $0, %rax           #CHECK if list not empty
    je end
    leaq head, %r15       
    movq %r15, %r12 
    movq (%rax), %rbx
    movq src, %rcx
    movq dst, %rdx
    movq $-1, %r8
    movq $-1, %r9
    movq $-1, %r10
   
    cmp %rcx, %rdx         #CHECK if src and dst are the same
    je end
iteration:
    cmp %rbx, %rcx         #cmp current father to src
    jne dst_check
    movq $0, %r9
    movq %rax, %r8     
    movq %r15, %r13
dst_check:
    cmp %rbx, %rdx         #cmp current father to dst
    jne finish_loop
    cmp $-1, %r9           #CHECK if dst found before src
    je end
    movq %rax, %r10
    movq %r15, %r14
    jmp switch_values
finish_loop:
    movq %rax, %r15
    movq 8(%rax), %rax      #update current father
    cmp $0x00, %rax         #CHECK if end of list 
    je end
    movq (%rax), %rbx
    cmp $-1, %r10
    je iteration
switch_values:
    movq 8(%r8), %rbx    # Son of src
    movq 8(%r10), %r9   # Son of dst
    cmp %rbx, %r10          #CHECK if dst is right after src
    je dst_right_after_src
                         # Switch src data(father and son)
    movq %r9, 8(%r8)
    movq %r8, 8(%r14)
                         # Switch dst data
    movq %rbx, 8(%r10)
    cmp %r12, %r13
    je head_situation       #CHECK if src is at the head
    movq %r10, 8(%r13)
    jmp end
    
dst_right_after_src:
    #movq (%r10), %rbx
    #movq (%r8),  %rax
    movq %r9, 8(%r8)        #src -> son_of_dst
    movq %r8, 8(%r10)       #dst -> src
    #movq %rbx, 8(%r13)      #src = dst
    #movq %rax, (%r10)
    cmp %r12, %r13
    je head_situation
    jmp end
    
head_situation:
    movq %r10, (%r13)
    
end:    

