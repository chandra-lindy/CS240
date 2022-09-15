;********************************************************************************************************************************
;Program name: "Right Triangles".
; This program will allow users to input two floating point numbers and determine which is the greater than the other by
; displaying the bigger number and returning the smaller number as a return value.
;
; Copyright (C) 2022 Chandra Lindy.
;
; This file is part of the software program "Right Triangles".
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
; version 3 as published by the Free Software Foundation.
;
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
; A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
;********************************************************************************************************************************

;================================================================================================================================
;Author information
;  Author name: Chandra Lindy
;  Author email: chandra.lindy@csu.fullerton.edu
;
;Program information
;  Program name: Right Triangles
;  Programming languages: Assembly x86-64, C, bash
;  Date program began: 2022 September 15th
;  Date of last update: 2022 September 15th
;  Date of reorganization of comments: 2022 September 15th
;  Files in this program: triangle.asm, pythagoras.c, r.sh
;  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
;
;This file
;   File name: triangle.asm
;   Language: X86 with Intel syntax.
;   Max page width: 129 columns
;   Assemble: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
;   Compile: gcc pythagoras.c triangle.o -o right-triangles
;   Link: g++ -m64 -no-pie -std=c++17 -o triangle.out pythagoras.o triangle.o
;   Purpose: This file displays a greetings message to the user and calls triangle function, then it displays the
;            return value of of triangle to the user before displaying a goodbye message.
;================================================================================================================================

; ********** CODE BEGIN **********
; include external functions
global triangle

; Data segment - initialize dvariable sand ocnstants goes here
segment .data
; ********** DECLARATIONS **********

; message strings declarations

; format strings declarations

; BSS segment - variables declerations
segment .BSS
; ********** DECLARATIONS **********

; Text segment - instructions begin here, includes some headers or labels tha define inital program
; ********** executable code begins **********
segment .text

triangle:

; backup GPRs
push      rbp
mov       rbp, rsp
push      rbx
push      rcx
push      rdx
push      rsi
push      rdi
push      r8
push      r9
push      r10
push      r11
push      r12
push      r13
push      r14
push      r15
pushf

; ******************** program logic begins ********************

; restore GPRs
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

; return control to caller
ret
