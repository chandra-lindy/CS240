extern printf
extern scanf
extern sum
extern input_float

segment .data

message_prompt_name db "Please enter your name: ", 10, 10, 0
message_prompt_array db "Please enter your array of integers separated by white space (cntl-d when finished): ", 10, 10, 0
message_display_array db "The following numbers were received and stored away in an array", 10, 10, 0
message_display_sum db "The sum of the %d numbers in this array is %d", 10, 10, 0
message_return db "This program will return execution to the main function", 10, 10, 0

segment .bss

segment .text

global manager
manager:

;Prolog ===== Insurance for any caller of this assembly module ========================================================
push rbp
mov  rbp,rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf

; ********** assembly code goes here **********

; example during SI session


;===== Restore original values to integer registers ===================================================================
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp

ret
