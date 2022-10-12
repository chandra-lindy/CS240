extern printf
extern scanf


segment .data

segment .bss

segment .text

global sum
sum:

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

; put array in a stable register
mov r15, rdi

; put n in a stable register
mov r14, rsi

; start a total count
mov r13, 0

; start loop counter
mov r12, 0

sum_array:
; check for end of array
cmp r12, r14
je end
; check for end of array
;mov rax, [r15 + 8 * r14]
;cdqe
;cmp rax, 0
;je end

; add integer to total count
add r13, [r15 + 8 * r12]
inc r12
jmp sum_array

end:
mov rax, r13


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
