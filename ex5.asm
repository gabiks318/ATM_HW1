.global main

.section .text
main:
#declerations

    xor %rax, %rax      # Current node adress
    xor %rbx, %rbx      # Current node value
    xor %rcx, %rcx      # Source node value
    xor %rdx, %rdx      # Destination node value
    xor %r8, %r8        # Source node adress
    xor %r9, %r9        # Source node index
    xor %r10, %r10      # Destination node adress
    xor %r11, %r11      # Destination node index
    xor %r12, %r12      # Index counter
# load values
    movq head, %rax
    movq (%rax), %rbx
    movq src, %rcx
    movq dst, %rdx
    movq $-1, %r8
    movq $-1, %r10

    cmp %rcx, %rdx
    je end
iteration:
    cmp %rbx, %rcx
    jne dst_check
    movq %rax, %r8
    movq %r12, %r9
dst_check:
    cmp %rbx, %rdx
    jne finish_loop
    movq %rax, %r10
    movq %r12, %r11
finish_loop:
    movq 8(%rax), %rax
    cmp $0x00,%rax
    je compare
    movq (%rax), %rbx
    inc %r12
 compare:
    cmp $-1, %r10
    je iteration
    cmp $-1, %r8
    je end
switch:
    movq %rdx,(%r8)
    movq %rcx, (%r10)
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
