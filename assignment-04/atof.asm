; *******************************************************************************************************************************
;Function name:  atof
; This function takes a char pointer of ascii representation of a float number and returns an IEEE754 float
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
;  Function name: atof
;  Programming languages: Assembly x86-64
;  Date program began: 2022 October 27th
;  Date of last update: 2022 October 28th
;  Date of reorganization of comments: 2022 October 29th
;  Files in this function: atof.asm
;  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
;
;This file
;   File name: atof.asm
;   Language: X86 with Intel syntax.
;   Max page width: 129 columns
;   Assemble: nasm -f elf64 -l atof.lis -o atof.o atof.asm
;   Link: <as appropriate>
;   Purpose: Convert ascii representation of floats into IEEE754 float
;
;Signature:  double atof(char * ascii_float)
;
;Disclaimer:  This function does not validate input!
;================================================================================================================================

global atof
; external functions

; constant declarations
period equ 46
null equ 0

segment .data
; initialized variable declarations

segment .bss
; variable declarations

segment .text

atof:

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
; save arguments, start counter and flag
mov rbx, rdi  ; string value to be converted
mov r14, 0 ; negative flag
mov r12, 0 ; character counter

; check for negative values
cmp byte [rbx], '-'
jne start

inc r14
inc r12

start:

; push integer portion onto stack as ascii values
peel_integer:
  cmp byte [rbx + r12], '.'
  je peel_integer_end

  ; match size for arithmetic operation
  mov r15b, byte [rbx + r12]
  cbw
  cwde
  cdqe

  ; push value onto stack
  push qword 0
  mov [rsp], r15
  inc r12
  jmp peel_integer

peel_integer_end:
; integer value (digist to the left of decimal) are on the stack

; get ready to convert integer value
; start a multiplier
mov rax, 1
cvtsi2sd xmm11, rax

; keep a 10.0 value in a register as the base of our multiplier
mov rax, 10
cvtsi2sd xmm12, rax

; make divisor value start at 0.1
divsd xmm11, xmm12

; start loop with integer digit counter, counting down
; pop off stack and convert the integer portion of our float
mov r13, r12 ; make a copy of our counter

; if it's a negative value there's one less digit on the stack
cmp r14, 0
je continue

sub r13, 1

continue:

; now we're ready to convert our integer portion
xorpd xmm14, xmm14 ; ready a register to keep a running count
convert_integer:
  cmp r13, 0 ; for as many ascii values we have on the stack
  je convert_integer_end

  pop r15 ; take one out
  sub r15, '0' ; convert ascii to int
  cvtsi2sd xmm13, r15 ; convert int to float
  mulsd xmm11, xmm12 ; multiply our multiplier by our base 10
  mulsd xmm13, xmm11 ; multiple our integer by our multiplier
  addsd xmm14, xmm13 ; keep a running count

  dec r13
  jmp convert_integer

convert_integer_end:
; xmm14 now holds the integer portion as a float with zeroes to the right side of the decimal


; now we work on the decimal portion
; start a divisor with 1 as starting value
xorpd xmm11, xmm11
mov rax, 1
cvtsi2sd xmm11, rax

inc r12  ; to move passed decimal point
xorpd xmm15, xmm15 ; ready a register for a running count
convert_decimal:
  ; are we at the end of the string yet?
  cmp byte [rbx + r12], null
  je convert_decimal_end

  ; match size
  mov r15b, byte [rbx + r12]
  cbw
  cwde
  cdqe

  sub r15, '0' ; convert ascii to int
  cvtsi2sd xmm10, r15 ; conver int to float
  mulsd xmm11, xmm12 ; multiply our divisor by our base 10
  divsd xmm10, xmm11 ; divide our number with our divisor
  addsd xmm15, xmm10 ; keep a running count

  inc r12
  jmp convert_decimal

convert_decimal_end:
; xmm15 now holds the decimal portion of our float

; all we have to do now is combine the two parts
addsd xmm14, xmm15 ; add the decimal portion to the integer portion
movsd xmm0, xmm14 ; load value ready for return to caller

; check if it's a negative value
cmp r14, 0
je end

; make it negative if it is
mov rax, -1
cvtsi2sd xmm9, rax
mulsd xmm0, xmm9

end:

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
