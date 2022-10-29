; *******************************************************************************************************************************
;Function name: scan
; This function scans stdin for user input
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
;  Function name: scan
;  Programming languages: Assembly x86-64
;  Date program began: 2022 October 27th
;  Date of last update: 2022 October 27th
;  Date of reorganization of comments: 2022 October 29th
;  Files in this function: scan.asm
;  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
;
;This file
;   File name: scan.asm
;   Language: X86 with Intel syntax.
;   Max page width: 129 columns
;   Assemble: nasm -f elf64 -l scan.lis -o scan.o scan.asm
;   Link: <as appropriate>
;   Purpose: scan stdin one character at a time until \n is found
;
;Signature:  void scan(char * buffer, int size)
;
;Disclaimer:  This function does not validate input!
;================================================================================================================================

global scan

; constant declarations
stdin equ 0
sys_read equ 0
new_line equ 10


segment .data

segment .bss

; variable declarations
one_char resb 1


segment .text

scan:

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
mov r15, rdi  ; char pointer
mov r14, rsi  ; max n char
add r14, 2 ; to account for newline and null terminator

; start counter
mov r13, 0
read:

; get one char from stdin
mov rax, sys_read
mov rdi, stdin
mov rsi, one_char
mov rdx, 1
syscall

; check for a newline
mov al, byte [one_char]
cmp al, new_line
je done

; check max n
inc r13
cmp r13, r14
jae read

; copy to char pointer
mov byte [r15], al
inc r15
jmp read


done:
; end char pointer with a newline
mov byte [r15 + r13], al


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
