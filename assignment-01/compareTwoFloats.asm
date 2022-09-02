;********************************************************************************************************************************
;Program name: "Compare Two Floats".
; This program will allow users to input two floating point numbers and determine which is the greater than the other by
; displaying the bigger number and returning the smaller number as a return value.
;
; Copyright (C) 2021 Chandra Lindy.
;
; This file is part of the software program "Compare Two Floats".
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
;  Program name: Compare Two Floats
;  Programming languages: Assembly x86-64, C++, C, bash
;  Date program began: 2022 August 31st
;  Date of last update: 2022 September 2nd
;  Date of reorganization of comments: 2021 September 2nd
;  Files in this program: compareTwoFloats.asm, driver.cpp, isfloat.cpp, run.sh
;  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
;
;This file
;   File name: compare-two-floats.asm
;   Language: X86 with Intel syntax.
;   Max page width: 129 columns
;   Assemble: nasm -f elf64 -l compareTwoFloats.lis -o compareTwoFloats.o compareTwoFloats.asm
;   Link: g++ -m64 -no-pie -std=c++17 -o compareTwoFloats.out driver.o isfloat.o compareTwoFloats.o
;   Purpose: Prompts user for input of two floating point numbers, validates them to ensure they are indeed floating points,
;            displays the two inputer numbers, displays the larger of the two and returns the smaller number to the caller.
;            If invalid number(s) were inputted, a message is displayed and a -1 is returned to the caller.
;================================================================================================================================

; ********** CODE BEGIN **********
extern    printf
extern    scanf
extern    isfloat
extern    atof
global    compareTwoFloats

; Data segment - initialize dvariable sand ocnstants goes here
segment .data
; ********** DECLARATIONS **********

; message strings declarations
prompt_message                 db    "Please enter two float numbers separated by white space.  Press enter after the second input.", 10, 10, 0
confirmation_message           db    10, "These numbers were entered:", 10, "%1.16lf", 10, "%1.16lf", 10, 10, 0
comparison_result_message      db    "The larger number is %1.16lf", 10, 10, 0
bad_input_message              db    10, "An invalid input was detected.  You may run this program again.", 10, 10, 0
return_message                 db    "This assembly module will now return execution to the driver module.", 10, "The smaller number will be returned to the driver", 10, 10, 0

; format strings declarations
float_f                        db    "%lf", 0
two_string_f                   db    "%s%s", 0

; Text segment - instructions begin here, includes some headers or labels tha define inital program
; ********** executable code begins **********
segment .text

compareTwoFloats:

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

; print input prompt message
mov       rax, 0
mov       rdi, prompt_message
call      printf

; grow stack to make room for two string inputs
sub       rsp, 2048
mov       r15, rsp
add       r15, 1024

; get input from user for first string
mov       rax, 0
mov       rdi, two_string_f
mov       rsi, rsp
mov       rdx, r15
call      scanf

; validate first string
mov       rax, 0
mov       rdi, rsp
call      isfloat
cmp       rax, 0
je        not_float

; validate second string
mov       rax, 0
mov       rdi, r15
call      isfloat
cmp       rax, 0
je        not_float

; convert first string to a float
mov       rax, 0
mov       rdi, rsp
call      atof
movsd     xmm14, xmm0

; convert second string to float
mov       rax, 0
mov       rdi, r15
call      atof
movsd     xmm15, xmm0

; restore stack - strings no longer needed
add rsp, 2048

; print confirmation message
mov       rax, 2
mov       rdi, confirmation_message
movsd     xmm0, xmm14
movsd     xmm1, xmm15
call      printf

; compare floats
ucomisd   xmm14, xmm15
jb        lessThan

; else swap positions
movsd     xmm13, xmm14
movsd     xmm14, xmm15
movsd     xmm15, xmm13

lessThan:
; display larger float value
mov       rax, 1
movsd     xmm0, xmm15
mov       rdi, comparison_result_message
call      printf

; display return message
mov       rax, 0
mov       rdi, return_message
call      printf

; set smaller number for return
movsd     xmm0, xmm14
jmp       final

not_float:
; restore stack - input strings no longer needed
add rsp, 2048

; display bad input message
mov       rax, 0
mov       rdi, bad_input_message
call      printf

; set -1 as return code
mov       rax, -1
cvtsi2sd  xmm0, rax

final:
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
