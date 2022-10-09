extern scanf


segment .data
; format string declaration
format_int db "%d", 0

segment .bss

segment .text

global input_array
input_array:

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

; ********** program logic begins **********

; secure array into a stable register
mov r15, rdi

; start a counter
mov r14, 0

; create space on stack for input number
sub rsp, 64

; prompt user for numbers to input into array
getNumber:
mov rax, 0
mov rdi, format_int
mov rsi, rsp
call scanf

; stop prompt if cntl-D
cdqe
cmp rax, -1
je continue

; input number into array
mov r10, [rsp]
mov [r15 + 8 * r14], r10
inc r14
jmp getNumber

continue:
add rsp, 64
mov rax, r14


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
