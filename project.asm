section .data
    num db 1 ; single value to be added
    num2 db 6 ;
    newline db 10 ; newline character

section .text
    global _start

_start:
    ; Load the value to be added into a register
    mov al, [num]

    ; Add 10 to the value
    add al, [num2]

    ; Store the result back to num
    mov [num], al

    ; Convert the result to ASCII
    mov bl, 10 ; divisor for tens place
    xor edx, edx ; clear high bits of edx
    movzx eax, al ; zero extend AL into EAX
    div bl ; divide EAX by 10, quotient will be in AL, remainder in AH

    ; Convert quotient (tens place) to ASCII
    add al, '0' ; convert tens place to ASCII

    ; Print tens place
    mov [result], al ; store the ASCII representation of tens place

    ; Print ones place
    mov al, ah ; get the remainder (ones place)
    add al, '0' ; convert ones place to ASCII
    mov [result + 1], al ; store the ASCII representation of ones place

    ; Print result
    mov edx, 2 ; length of output (two ASCII characters)
    mov ecx, result ; pointer to the result
    mov ebx, 1 ; file descriptor (stdout)
    mov eax, 4 ; system call number for sys_write
    int 0x80 ; call kernel

    ; Print newline character
    mov edx, 1 ; length of newline character
    mov ecx, newline ; pointer to newline character
    mov ebx, 1 ; file descriptor (stdout)
    mov eax, 4 ; system call number for sys_write
    int 0x80 ; call kernel

    ; Exit the program
    mov eax, 1 ; system call number for sys_exit
    xor ebx, ebx ; exit code 0
    int 0x80 ; call kernel

section .bss
    result resb 2 ; to store the ASCII representation of the result