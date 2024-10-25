.section .data
.equ RECORD_SIZE, 58
output_file:
    .ascii "enemy_rec.dat\0"
enemy_skeleton:
    #name
    .ascii "skeleton"
    .rept 32
    .byte 0
    .endr
    # hp_str:
    .ascii "HP: "
    # hp:
    .long 100
    # atk_str:
    .ascii "atk: "
    # atk:
    .long 10
enemy_goblin:
    #name
    .ascii "Goblin"
    .rept 34
    .byte 0
    .endr
    # hp_str:
    .ascii "HP: "
    # hp:
    .long 50
    # atk_str:
    .ascii "atk: "
    # atk:
    .long 20

enemy_troll:
    #name
    .ascii "Troll"
    .rept 35
    .byte 0
    .endr
    # hp_str:
    .ascii "HP: "
    # hp:
    .long 300
    # atk_str:
    .ascii "atk: "
    # atk:
    .long 20

.section .text
.globl _start
_start:
    # Open the output file for writing (O_CREAT | O_WRONLY)
    movl $5, %eax           # syscall: open
    movl $output_file, %ebx # filename
    movl $02001, %ecx # flags
    movl $0666, %edx       # mode
    int $0x80               # call kernel

    movl %eax, %ebx         # store file descriptor

    # Write enemy_skeleton
    movl $4, %eax           # syscall: write
    movl %ebx, %ebx         # file descriptor
    movl $enemy_skeleton, %ecx # buffer
    movl $RECORD_SIZE, %edx # size
    int $0x80               # call kernel

    # Write enemy_troll
    movl $4, %eax           # syscall: write
    movl %ebx, %ebx         # file descriptor
    movl $enemy_troll, %ecx # buffer
    movl $RECORD_SIZE, %edx # size
    int $0x80               # call kernel

    # Write enemy_goblin
    movl $4, %eax           # syscall: write
    movl %ebx, %ebx         # file descriptor
    movl $enemy_goblin, %ecx # buffer
    movl $RECORD_SIZE, %edx # size
    int $0x80               # call kernel

    # Close the file
    movl $6, %eax           # syscall: close
    movl %ebx, %ebx         # file descriptor
    int $0x80               # call kernel

    # Exit the program
    movl $1, %eax           # syscall: exit
    xorl %ebx, %ebx         # exit code 0
    int $0x80               # call kernel
