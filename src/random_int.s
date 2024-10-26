    .section .data
urandom:
    .ascii "/dev/urandom\0"
.section .text
    .globl random_int
    .type random_int, @function
    #PURPOSE: Provide a random ingeger from 0-parameter
    #INPUT: one paramater which is the upper range(long)
    #OUTPUT: returns the random number in %eax
random_int:
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp # Make space on stack for local varible
    # Open urandom file
    movl $5, %eax
    movl $urandom, %ebx
    movl $0, %ecx
    movl $0666, %edx
    int $0x80

    movl %eax, %ebx
    # Read one integer from file
    movl $3, %eax
    movl -4(%ebp), %ecx
    movl $4, %edx

    #Modulo operation for desired range
    movl -4(%ebp), %eax
    movl 8(%ebp), %ecx
    xorl %edx, %edx
    divl %ecx

    # incease range from [0-2] to [1-3]
    incl %edx

    # Close file
    movl $6, %eax
    int $0x80
    movl %edx, %eax

    movl %ebp, %esp
    popl %ebp
    ret
