; *******************************************************************************************************************************
;Function name:  ftoa
; This function converts IEEE754 float into its ascii representation of the value
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
;  Function name: ftoa
;  Programming languages: Assembly x86-64
;  Date program began: 2022 October 28th
;  Date of last update: 2022 October 28th
;  Date of reorganization of comments: 2022 October 29th
;  Files in this function: ftoa.asm
;  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
;
;This file
;   File name: ftoa.asm
;   Language: X86 with Intel syntax.
;   Max page width: 129 columns
;   Assemble: nasm -f elf64 -l ftoa.lis -o ftoa.o ftoa.asm
;   Link: <as appropriate>
;   Purpose: convert float to ascii
;
;Signature:  void ftoa(double value, char * string)
;
;Disclaimer:  This function does not validate input!
;================================================================================================================================

global ftoa
; external functions

; constant declarations

segment .data
; initialized variable declarations
d_zero dq 0.0
d_neg_one dq -1.0
d_ten dq 10.0
d_one dq 1.0
q_period dq '.'
limit db 10

segment .bss
; variable declarations

segment .text

ftoa:

; Prolog ===== Insurance for any caller of this assembly module ========================================================
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
movsd xmm15, xmm0
mov rbx, rdi

; start counters and flags
mov r11, 10 ; digit limit
mov r12, 0 ; char pointer counter
mov r13, 0 ; decimal counter
mov r14, 0 ; stack counter

; check if negative
ucomisd xmm15, [d_zero]
jae start

mov byte [rbx], '-'
mulsd xmm15, [d_neg_one]
inc r12

start:

; check if float - interger portion of float = 0?
move_decimal:
  cvtsd2si eax, xmm15
  cvtsi2sd xmm14, eax
  subsd xmm14, xmm15
  ucomisd xmm14, [d_zero]
  je convert
  cmp r11, 0
  je convert
  ; move decimal over
  mulsd xmm15, [d_ten]
  inc r13
  dec r11
  jmp move_decimal


convert:
; convert float to int
cvtsd2si r15, xmm15

decimal_to_ascii:
  cmp r13, 0
  je part_two

  ; remove LSD
  mov rax, r15
  cqo
  mov r15, 10
  idiv r15
  mov r15, rax ; keep track of quotient for continuation to part two

  ; convert and push onto stack
  add rdx, '0'
  push rdx

  dec r13
  inc r14
  jmp decimal_to_ascii

part_two:

push qword '.'
inc r14

integer_to_ascii:
  ; remove LSD
  mov rax, r15
  cqo
  mov r15, 10
  idiv r15
  mov r15, rax ; when quotient is 0 we know to stop
  cmp r15, 0
  je push_last

  ; convert and push onto stack
  add rdx, '0'
  push rdx

  dec r13
  inc r14
  jmp integer_to_ascii


; convert and push the last digit
push_last:
add rdx, '0'
push rdx
inc r14

; load char pointer
load_return:
  cmp r14, 0
  je done

  pop rax
  mov [rbx + r12], rax
  inc r12
  dec r14
  jmp load_return

done:
; add null terminator for our string
inc r12
mov byte [rbx + r12], 0

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
