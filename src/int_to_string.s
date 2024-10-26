.section .data
buffer: .space 12             # Buffer space for the result (enough for a 32-bit integer + sign + null terminator)

.section .text
.global int_to_str
.type int_to_str, @function

# PURPOSE: Convert an integer in %eax to its string representation in 'buffer'
# INPUT: %eax contains the integer to convert
# OUTPUT: Returns address of 'buffer' in %eax, a null-terminated string representation
int_to_str:
    pushl %ebp
    movl %esp, %ebp

    movl %eax, %ecx            # Copy input integer to %ecx
    leal buffer, %edi          # Load address of 'buffer' into %edi
    addl $11, %edi             # Point to the end of the buffer (to fill in reverse)

    # Write null terminator
    movb $0, (%edi)
    decl %edi

    # Convert integer to string
    movl $10, %ebx             # Set divisor to 10
convert_loop:
    xorl %edx, %edx            # Clear %edx before div
    divl %ebx                  # Divide %eax by 10; quotient in %eax, remainder in %edx

    addb $'0', %dl             # Convert remainder (0-9) to ASCII character
    movb %dl, (%edi)           # Store ASCII character in buffer
    decl %edi                  # Move buffer pointer left for next character

    testl %eax, %eax           # Check if quotient is zero
    jnz convert_loop           # If not zero, keep processing

    leal 1(%edi), %eax         # Set %eax to point to the start of the string

    movl %ebp, %esp
    popl %ebp
    ret
