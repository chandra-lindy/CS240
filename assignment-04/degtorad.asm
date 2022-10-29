; *******************************************************************************************************************************
;Function name:  degtorad
; This function converts degrees to radians
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
;  Function name: degtorad
;  Programming languages: Assembly x86-64
;  Date program began: 2022 October 28th
;  Date of last update: 2022 October 28th
;  Date of reorganization of comments: 2022 October 29th
;  Files in this function: degtorad.asm
;  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
;
;This file
;   File name: degtorad.asm
;   Language: X86 with Intel syntax.
;   Max page width: 129 columns
;   Assemble: nasm -f elf64 -l degtorad.lis -o degtorad.o degtorad.asm
;   Link: <as appropriate>
;   Purpose: Convert degrees to radians
;
;Signature:  double degtorad(double degrees)
;
;Disclaimer:  This function does not validate input!
;================================================================================================================================


global degtorad
; external functions

; constant declarations

segment .data
; initialized variable declarations
pi dq 0x400921fb54442d18
one_eighty dq 180.0

segment .bss
; xmm register backup
align 64
backup resb 832

; variable declarations

segment .text

degtorad:

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
movsd xmm15, xmm0

; radians is:
; degree * pi
movsd xmm14, [pi]
mulsd xmm15, xmm14
divsd xmm15, [one_eighty]
movsd xmm0, xmm15

; ********** program logic ends ************


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
