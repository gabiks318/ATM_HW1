.global main

.section .text
main:
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
    #movq %r12, %r9     
dst_check:
    cmp %rbx, %rdx
    jne finish_loop
    movq %rax, %r10
    movq %r15, %r14
    #movq %r12, %r11
finish_loop:
    movq %rax, %r15         #update current father
    movq 8(%rax), %rax
    cmp $0x00, %rax
    je check_if_found
    movq (%rax), %rbx
    #inc %r12
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
switch:
    movq 8(%r10), %rax   #son of dest
    movq 8(%r8), %rbx   #son of src
    movq %rbx, 8(%r8)    #move src-son 
    cmp %r12, %r13
    je head_situation
    movq %r10, 8(%r13) 
    jmp src_switch
head_situation:
    movq %r10, (%r13)
src_switch:
    movq %rax, 8(%r10)
    movq %r8, 8(%r14)
end:    
  cmpq $BNode, head
  jne bad
  cmpq $5, ANode
  jne bad
  cmpq $NULL, ANode+8
  jne bad
  cmpq $4, BNode
  jne bad
  cmpq $ANode, BNode+8
  jne bad
correct:
  movq $60, %rax
  movq $0, %rdi
  syscall
bad:
      movq $60, %rax
  movq $1, %rdi
  syscall
  
  
.section .data
src: .quad 5
dst: .quad 4
head: .quad ANode
ANode:  .quad 5
    .quad BNode
BNode:  .quad 4
    .quad NULL
.set NULL, 0
