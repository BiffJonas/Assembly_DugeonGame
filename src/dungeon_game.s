    .section .data
greeting_msg:
    .ascii "Welcome weary and silly traveler!\0"
option_msg:
    .ascii "What would you like to do?\nTravel To Town(1) | Enter the Dungeon!(2)\n\0"
town_msg:
    .ascii "You travel into town\0"
dungeon_msg:
    .ascii "You enter the Dungeon!!!\0"
invalid_opt_msg:
    .ascii "That's not an option dummy!\n\0"

enc_enemy_msg:
    .ascii "You stumble upon a Skeleton!\n\0"
enemy_hp:
    .long 100
battle_choice_msg:
    .ascii "How do you want to handle this foe?\n"
    .ascii "Flee(1) | Battle to the death(2)\0"

    .section .bss
    .equ BUFFER_SIZE, 10
    .lcomm CHOICE_BUFFER, BUFFER_SIZE

    .section .text
    .globl _start
_start:
    pushl $greeting_msg
    call print_stdout
    addl $4, %esp

    pushl $option_msg
    call print_stdout
    addl $4, %esp

    # Read Choice

read_choice:
    movl $3, %eax
    movl $0, %ebx
    movl $CHOICE_BUFFER, %ecx
    movl $BUFFER_SIZE, %edx
    int $0x80

    # TODO: Make function that handles user input and validation. Params(choice_msg, number_of_choices)
handle_travel_choice:
    movb CHOICE_BUFFER, %al
    cmpb $'1', %al
    je travel_town
    cmpb $'2', %al
    je enter_dungeon
    
    pushl $invalid_opt_msg
    call print_stdout
    addl $4, %esp
    jmp read_choice



    # Print choic for testing
    # pushl $CHOICE_BUFFER
    # call print_stdout
    # addl $4, %esp

exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80

travel_town:
    pushl $town_msg
    call print_stdout
    addl $4, %esp
    jmp exit
enter_dungeon:
    pushl $dungeon_msg
    call print_stdout
    addl $4, %esp

    pushl $enc_enemy_msg
    call print_stdout
    addl $4, %esp

    pushl $battle_choice_msg
    call print_stdout
    addl $4, %esp
    jmp exit

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
