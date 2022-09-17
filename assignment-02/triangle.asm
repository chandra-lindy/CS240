;********************************************************************************************************************************
;Program name: "Right Triangles".
; This program will take the length of two sides of a triangle and returns the length of the hypotenuse.  We do this after we
; politely greet the user of course!
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
;  Date of last update: 2022 September 16th
;  Date of reorganization of comments: 2022 September 16th
;  Files in this program: triangle.asm, pythagoras.c, r.sh
;  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
;
;This file
;   File name: triangle.asm
;   Language: X86 with Intel syntax.
;   Max page width: 129 columns
;   Assemble: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
;   Compile: gcc -Wall -fno-pie -no-pie pythagoras.c triangle.o -o right-triangles.out
;   Purpose: Politely calculate the hypotenuse of a triangle given length of two sides of a triangle
;================================================================================================================================

; ********** CODE BEGIN **********
; include external functions
extern printf
extern scanf
extern atof
extern read
extern strlen
extern sqrt

; set constant values
INPUT_LEN equ 256


; Data segment - initialize dvariable sand ocnstants goes here
segment .data
; ********** DECLARATIONS **********

; message strings declarations
message_prompt_name db "Please enter your last name: ",10, 10, 0
message_prompt_title db 10, "Please enter your title (Mr, Ms, Nurse, Engineer, Donut Eater, etc): ", 10, 10, 0
message_prompt_sides db 10, "Please enter the sides of your triangle separated by a white space: ", 10, 10, 0
message_result db 10, "The length of the hypotenuse is %1.5lf units long.", 10, 10, 0
message_goodbye db "Enjoy your triangles %s %s", 10, 10, 0

; format strings declarations
f_float db "%lf", 0
f_two_strings db "%s%s", 0

; BSS segment - variables declerations
segment .bss
; ********** DECLARATIONS **********
last_name resb INPUT_LEN
title resb INPUT_LEN



; Text segment - instructions begin here, includes some headers or labels tha define inital program
; ********** executable code begins **********
segment .text

global triangle
triangle:

; backup GPRs
push rbp
mov  rbp, rsp
push rbx
push rcx
push rdx
push rsi
push rdi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

; ******************** program logic begins ********************

; prompt user for last name
;; display prompt
mov rax, 0
mov rdi, message_prompt_name
call printf
;; get input from user
mov rax, 0
xor rdi, rdi
mov rsi, last_name
mov rdx, INPUT_LEN
call read
; remove newline character
mov rax, 0
mov rdi, last_name
call strlen
sub rax, 1
mov byte [last_name + rax], 0



; prompt user for title
;; display prompt
mov rax, 0
mov rdi, message_prompt_title
call printf
;; read input from user
mov rax, 0
xor rdi, rdi
mov rsi, title
mov rdx, INPUT_LEN
call read
; remove newline character
mov rax, 0
mov rdi, title
call strlen
sub rax, 1
mov byte [title + rax], 0



; prompt user for sides of their triangle
;; reserve memory on stack for input
sub       rsp, 128
mov       r15, rsp
add       r15, 64
promptSides:
;; display prompt
mov rax, 0
mov rdi, message_prompt_sides
call printf
;; read input from user
mov rax, 0
mov rdi, f_two_strings
mov rsi, rsp
mov rdx, r15
call scanf
;; convert strings to floats
;;; first string
mov rax, 0
mov rdi, rsp
call atof
movsd xmm14, xmm0
;;; second string
mov rax, 0
mov rdi, r15
call atof
movsd xmm15, xmm0
;; check for invalid values (n <= 0)
;;; zero out a register for comparison
pxor xmm13, xmm13
;;; first side
ucomisd xmm14, xmm13
jbe promptSides
;;; second side
ucomisd xmm15, xmm13
jbe promptSides
;; release memory off stack values no longer needed
add rsp, 128



; compute hypotenuse
;; calculate sum of squared sides
mulsd xmm14, xmm14
mulsd xmm15, xmm15
addsd xmm15, xmm14
sqrtsd xmm15, xmm15



; display result
mov rax, 1
mov rdi, message_result
movsd xmm0, xmm15
call printf



; display goodbye message
mov rax, 0
mov rdi, message_goodbye
mov rsi, title
mov rdx, last_name
call printf


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

; return value and control to caller
movsd xmm0, xmm15
ret
