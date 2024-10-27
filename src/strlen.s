    .section .text
    .globl strlen
    .type strlen,@function
    # Takes one parameter which is the string to calculate the length of
    # %edi holds the current index. If that index is a null byte then the function ends and moves %edi to %eax
    # Returns the length in %eax
strlen:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ecx
    movl $0, %edi
strlen_loop:
    cmpb $0, (%ecx, %edi, 1)
    je strlen_end
    incl %edi
    jmp strlen_loop

strlen_end:
    movl %edi, %eax
    movl %ebp, %esp
    popl %ebp
    ret
