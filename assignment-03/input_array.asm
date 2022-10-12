extern scanf
extern is_integer
extern atoi


segment .data
; format string declaration
format_int db "%s", 0

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
mov r14, rsi

; start a counter
mov r13, 0

; create space on stack for input number
sub rsp, 64
jmp getNumber

; set flag to true if invalid input found
invalid:
inc qword [r14 + 8]

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

; validate input
mov rax, 0
mov rdi, rsp
call is_integer
cdqe
cmp rax, -1
je invalid


; convert string to integer
mov rax, 0
mov rdi, rsp
call atoi

; input number into array
mov r10, rax
mov [r15 + 8 * r13], r10
inc r13
jmp getNumber

continue:
add rsp, 64
mov [r14], r13


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
