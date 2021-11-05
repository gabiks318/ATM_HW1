.global _start



.text
_start:
#your code here
    xor %eax, %eax # num
    movl num, %eax
    cmp $0, %eax
    js is_negative
    xor %rbx, %rbx
    xor %r8, %r8
    xor %rdx, %rdx
    leaq source, %rbx # source
    leaq destination, %rdx   # destination
loop:    
    movb (%rbx), %r8b
    movb %r8b, (%rdx)
    dec %rax
    inc %rbx
    inc %rdx
    cmp $0, %eax
    jne loop
    jmp end
is_negative:
    movl %eax, destination
end:
  