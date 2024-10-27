    .section .text
    .globl print_stdout
    .type print_stdout,@function
print_stdout:
    pushl %ebp
    movl %esp, %ebp

    #calculate string length
    pushl 8(%ebp)
    call strlen
    addl $4, %esp
    movl %eax, %edx

    movl $4, %eax
    movl $1, %ebx
    movl 8(%ebp), %ecx
    int $0x80

    movl %ebp, %esp
    popl %ebp
    ret
