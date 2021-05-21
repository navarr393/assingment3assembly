
;Author Information:                                                                       
;Name:         David Navarro                                                               
;Email:        navarrod253n@csu.fullerton.edu                                                
;Institution:  California State University - Fullerton                                     
;Course:       CPSC 240-01 Assembly Language                                               

extern printf
extern scanf
extern atof
extern isfloat
global fill                ; Makes function callable from other linked files.

section .data
    input_message db "Enter float numbers separated by white space. Invalid inputs will be omitted.", 10, 0
    input_message2 db "Enter control+D to terminate.",10,0
    float_format db "%s", 0

section .bss

section .text

fill:

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
mov r15, rdi                      ; Address of array saved to r15.
mov r14, rsi                      ; Max number of elements allowed in array.
mov r13, 0                        ; Set counter to 0 elements in Array.

;Display a prompt message asking for inputs
push qword 0
mov rax, 0
mov rdi, input_message          ;"Please enter floating point numbers separated by ws. "
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, input_message2         ;"When finished press enter followed by cntl+D."
call printf
pop rax

begin_loop:

;Begin the scanf block
sub rsp, 1024 ;creates room for string
mov rax, 0
mov rdi, float_format
mov rsi, rsp
call scanf

; Tests if Control + D is entered to finish inputing into array.
cdqe
cmp rax, -1                          
je end_of_loop                          ; If control + D is entered, jump to end_of_loop.

;check for valid input
mov rdi, rsp
call isfloat
cmp rax, 0 ;if a zero is returned then it is invalid
je invalid

;convert to float 
mov rax, 0                                                                                                            
mov rdi,rsp                                                                                                           
call atof
movsd xmm15, xmm0
add rsp, 1024

;mov r11, 1
;cvtsi2sd xmm10, r11 ;converts 1 to float and stores it in xmm10

movsd xmm15, xmm0
;divsd xmm10, xmm15
movsd [r15 + 8 * r13], xmm15            ; Copies user input into array at index of r13.
inc r13                                 ; Increments counter r13 by 1.

;-----------------------------ARRAY CAPACITY TEST-------------------------------------------
; Tests to see if max array capacity has been reached.
cmp r13, r14                            ; Compares # of elements (r13) to capacity (r14).
je exit                                ; If # of elements equals capacity, exit loop.

jmp begin_loop

end_of_loop:
add rsp, 1024
jmp exit

invalid:
add rsp, 1024
jmp begin_loop

exit:

pop rax                        ;Reverse the push near the beginning of this asm function.

mov rax, r13           ;Select the largest value for return to caller.

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