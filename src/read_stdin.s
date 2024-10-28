    .section .data
buffer:
    .space 4
.section .text
    .globl read_stdin
    .type read_stdin, @function
read_stdin:
    pushl %ebp
    movl %esp, %ebp

    movl $3, %eax
    movl $0, %ebx
    movl $buffer, %ecx
    movl $4, %edx
    int $0x80

    movl buffer, %eax

    movl %ebp, %esp
    popl %ebp
    ret
