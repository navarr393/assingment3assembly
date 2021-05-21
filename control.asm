;Author Information:                                                                       
;Name:         David Navarro                                                               
;Email:        navarrod253n@csu.fullerton.edu                                                
;Institution:  California State University - Fullerton                                     
;Course:       CPSC 240-01 Assembly Language  

global control
extern printf
extern scanf
extern fill
extern display
extern sum
array_size equ 10                ; Capacity limit for number of elements allowed in array.

section .data

    floats_entered db "Thank you, you entered:",10,0
    total_sum db "The harmonic mean of all the values is %5.8lf",10,0
    return_sum db "The harmonic mean will be returned to the driver.",10,0

section .bss
    floatArray resq 10                ; Uninitialized array with 100 reserved qwords.

section .text

control:

push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;Registers rax, rip, and rsp are usually not backed up.
push qword 0
;-----------------------------INITIALIZE PARAMETERS-----------------------------------------
mov r14, 0                        ; Reserve register for number of elements in array.
mov r13, 0                        ; Reserve register for Sum of integers in array

;====================================CALL FILL FUNCTION========================================================================

mov rdi, floatArray
mov rsi, array_size
mov rax, 0                     
call fill
mov r14, rax

push qword 0                                                   
mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, floats_entered        ;'The numers you entered are these:'
call printf
pop rax

;====================================CALL DISPLAY FUNCTION========================================================================

push qword 0  
mov rdi, floatArray            ;passes the array to display as first parameter
mov rsi, r14                   ;passes the index to display as second parameter
mov rax, 0
call display
pop rax

;====================================CALL SUM FUNCTION============================================================
push qword 0
mov rdi, floatArray            ;passes array
mov rsi, r14                   ;number of elements
mov rax, 0
call sum
movsd xmm13, xmm0              ;passes the return of the sum to xmm13
movsd xmm5, xmm13              ;moves the sum to xmm5
pop rax                                               
;====================================PRINT SUM========================================================================
push qword 0
mov rax, 1
movsd xmm5, xmm13
mov rdi, total_sum             ;'the harmonic mean of all the values is
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, return_sum         ;"The harmonic mean will be returned to the driver."
call printf
pop rax

pop rax                        ;Reverse the push near the beginning of this asm function.

movsd xmm0, xmm5             ;Select the largest value for return to caller.

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret