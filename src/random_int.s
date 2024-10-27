    .section .data
urandom_path: .ascii "/dev/urandom\0"  # File path for /dev/urandom

    .section .bss
    .lcomm random_number, 4 
    .section .text
    .globl random_int
    .type random_int, @function
    #PURPOSE: Provide a random ingeger from 0-parameter
    #INPUT: one paramater which is the upper range(long)
    #OUTPUT: returns the random number in %eax
random_int:
    pushl %ebp
    movl %esp, %ebp

    movl $5, %eax                          # sys_open system call number (5)
    movl $urandom_path, %ebx               # Path to /dev/urandom
    movl $0, %ecx                          # Flags (0 = O_RDONLY)
    int $0x80                              # Make system call

    # Store file descriptor in ebx for later read call
    movl %eax, %ebx                        # Move file descriptor to %ebx

    # Read 4 bytes (one integer) from /dev/urandom into random_number
    movl $3, %eax                          # sys_read system call number (3)
    movl $random_number, %ecx              # Buffer to store the read integer
    movl $8, %edx                          # Number of bytes to read
    int $0x80                              # Make system call

    movl random_number, %eax

    movl 8(%ebp), %ecx         # load the upper range parameter (1st argument)
    xorl %edx, %edx            # clear EDX for division
    divl %ecx                   # divide EAX by upper range
    incl %edx    

    # Close /dev/urandom
    movl $6, %eax                          # sys_close system call number (6)
    int $0x80                              # Make system call to close file

    movl %edx, %eax
    
    movl %ebp, %esp
    popl %ebp
    ret
