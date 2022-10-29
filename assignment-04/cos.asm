; *******************************************************************************************************************************
;Function name:  cos
; This function calculates cosine
;
; Copyright (c) 2022 Chandra Lindy
;
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
;
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
; of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License along with this program.
; If not, see <https://www.gnu.org/licenses/>.
; *******************************************************************************************************************************

;================================================================================================================================
;Author information
;  Author name: Chandra Lindy
;  Author email: chandra.lindy@csu.fullerton.edu
;
;Program information
;  Function name: cos
;  Programming languages: Assembly x86-64
;  Date program began: 2022 October 28th
;  Date of last update: 2022 October 28th
;  Date of reorganization of comments: 2022 October 29th
;  Files in this function: cos.asm
;  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
;
;This file
;   File name: cos.asm
;   Language: X86 with Intel syntax.
;   Max page width: 129 columns
;   Assemble: nasm -f elf64 -l cos.lis -o cos.o cos.asm
;   Link: <as appropriate>
;   Purpose: Calculate cosine
;
;Signature:  double cos(double value)
;
;Disclaimer:  This function does not validate input!
;================================================================================================================================

global cos
; external functions

; constant declarations

segment .data
; initialized variable declarations
d_zero dq 0.0
d_one dq 1.0
d_two dq 2.0
d_neg_one dq -1.0

segment .bss
; variable declarations

segment .text

cos:

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
; save arguments
movsd xmm8, xmm0 ; x in our equation

; implement t(n+1) = T(n) * -1 (x^2)/((2n+1)*(2n+2))
; over 10,000,000 iterations = cos(x)

; T(n) - 1st term
mov rax, 1
cvtsi2sd xmm9, rax

; n
movsd xmm10, [d_zero]

; sequence sum
movsd xmm15, [d_one]

; set counter
mov r12, 0
loop:
  cmp r12, 10000000
  je end

  ; T(n) * -1
  mulsd xmm9, [d_neg_one]
  ; * x^2
  mulsd xmm9, xmm8
  mulsd xmm9, xmm8
  ; / 2n + 1
  movsd xmm11, xmm10
  mulsd xmm11, [d_two]
  addsd xmm11, [d_one]
  divsd xmm9, xmm11
  ; / 2n + 2
  addsd xmm11, [d_one]
  divsd xmm9, xmm11

  ; add to sequence sum
  addsd xmm15, xmm9

  ; increment
  addsd xmm10, [d_one]
  inc r12
  jmp loop
end:

; load return value
movsd xmm0, xmm15

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
