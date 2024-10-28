    .include "./src/enemy_rec_def.s"
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
    ; .equ BUFFER_SIZE, 10
    ; .lcomm CHOICE_BUFFER, BUFFER_SIZE

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
    call read_stdin

    # TODO: Make function that handles user input and validation. Params(choice_msg, number_of_choices)
handle_travel_choice:
    cmpb $'1', %al
    je travel_town
    cmpb $'2', %al
    je enter_dungeon
    
    pushl $invalid_opt_msg
    call print_stdout
    addl $4, %esp
    jmp read_choice

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


