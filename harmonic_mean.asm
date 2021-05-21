;Author Information:                                                                       
;Name:         David Navarro                                                               
;Email:        navarrod253n@csu.fullerton.edu                                                
;Institution:  California State University - Fullerton                                     
;Course:       CPSC 240-01 Assembly Language                                               

global sum                             

section .data     

section .bss

section .text

sum:
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

mov r15, rdi                            ; Copies array that was passed to r15.
mov r14, rsi                            ; Copies number of elements in the array to r14.
mov r13, 0 
cvtsi2sd xmm14, r13
;movsd xmm0, xmm14                      ; Sum register to add elements of array to.
mov r12, 0                              ; Counter to to iterate through array.
mov r13, r12
;===============================================begin loop=================================================================================
begin_loop:
; Compares the counter r12 to the number of elements in the array r14.
cmp r12, r14                        
jge outofloop

;===============================================copy into array================================================================================
;movsd xmm0, xmm14
mov r11, 1
cvtsi2sd xmm10, r11 ;converts 1 to float and stores it in xmm10
divsd xmm10, [r15 + 8 * r12]
addsd xmm14, xmm10    ;moves the sum to xmm14
inc r12

jmp begin_loop

outofloop:

pop rax                        ;Reverse the push near the beginning of this asm function.
cvtsi2sd xmm9, r12
divsd xmm9, xmm14
movsd xmm0, xmm9         ;Select the largest value for return to caller.

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