.global _start

.text
_start:
#save to another reg
    movq num, %rax    #copy of num
    xorq %rbx, %rbx   #countBits
    xorq %rcx, %rcx   #loop counter
loop:
    sar %rax
    jae next_loop
    addq $1, %rbx
next_loop:
    cmp $63 ,%rcx
    je end
    addq $1, %rcx
    jmp loop
end:
    movl %ebx, countBits