; external resource declaration
;; custom library
extern printf
extern scanf
extern sum
extern input_array
extern display_array

;; standard library
extern strlen
extern read

; declare constant values
INPUT_LEN equ 256


segment .data
; message string declaration
message_prompt_name db "Please enter your name: ", 10, 10, 0
message_prompt_array db 10, "Please enter your array of integers separated by white space (cntl-d when finished): ", 10, 10, 0
message_display_array db "The following numbers were received and stored away in an array", 10, 10, 0
message_display_sum db "The sum of the %d numbers in this array is %d", 10, 10, 0
message_display_omit db 10, "One or more numbers were invalid and were omitted from the array", 10, 10, 0
message_return db "This program will return execution to the main function", 10, 10, 0

; declare return result for input_array
; first value is n = 0 - to be used as counter in inptu_array
; second value boolean flag for invalid input; 0 false; 1 true
arr_info dq 0, 0

segment .bss
; declare variable to store name
name resb INPUT_LEN
; declare int array
int_arr resq 200


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

; ********** program logic begins **********

; prompt user name
;; display prompt message for name
mov rax, 0
mov rdi, message_prompt_name
call printf

;; get input from user
mov rax, 0
xor rdi, rdi
mov rsi, name
mov rdx, INPUT_LEN
call read

;; remove newline character
mov rax, 0
mov rdi, name
call strlen
sub rax, 1
mov byte [name + rax], 0

; prompt user for integers
;; display prompt message for array
mov rax, 0
mov rdi, message_prompt_array
call printf

;; get input from user
mov rax, 0
mov rdi, int_arr
mov rsi, arr_info
call input_array

; display value omittion if any
mov rax, [arr_info + 8]
cdqe
cmp rax, 0
je no_invalid

; display omit message
mov rax, 0
mov rdi, message_display_omit
call printf

no_invalid:
; display integers
mov rax, 0
mov rdi, int_arr
call display_array

; sum array
mov rax, 0
mov rdi, int_arr
call sum
mov r15, rax

; display sum
mov rax, 0
mov rdi, message_display_sum
mov rsi, [arr_info]
mov rdx, r15
call printf

; return name to driver
mov rax, name

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
