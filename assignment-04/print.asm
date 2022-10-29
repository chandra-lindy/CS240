; *******************************************************************************************************************************
;Function name:  print
; This function prints string to console (stdout)
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
;  Function name: print
;  Programming languages: Assembly x86-64
;  Date program began: 2022 October 27th
;  Date of last update: 2022 October 27th
;  Date of reorganization of comments: 2022 October 29th
;  Files in this function: print.asm
;  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
;
;This file
;   File name: print.asm
;   Language: X86 with Intel syntax.
;   Max page width: 129 columns
;   Assemble: nasm -f elf64 -l print.lis -o print.o print.asm
;   Link: <as appropriate>
;   Purpose: Prints string to stdout
;
;Signature:  void print(char * string)
;
;Disclaimer:  This function does not validate input!
;================================================================================================================================

global print

; constant declarations
stdout equ 1
sys_write equ 1
new_line equ 10


segment .data

segment .bss

segment .text

print:

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

; save arguments into more stable registers
  mov rbx, rdi
  mov rdx, 0

loop_start:
  ; check for null terminator
  cmp byte [rbx], 0
  je loop_end

  ; count and advance
  inc rbx
  inc rdx
  jmp loop_start

loop_end:
  ; if string length is 0 then nothing to output
  cmp rdx, 0
  je done

  ; output message
  mov rax, sys_write
  mov rsi, rdi
  mov rdi, stdout
  syscall

done:

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
