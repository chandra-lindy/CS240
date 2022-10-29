;++++++++++++++++++++++++++++++++++++++++++++++++++++++;
;This function was used as part of a larger program by ;
; Author: Chandra Lindy                                ;
; Contact:  chandra.lindy@csu.fullerton.edu            ;
; Program:  Pure                                       ;
; Date incorporated:  October 28th, 2022               ;
;++++++++++++++++++++++++++++++++++++++++++++++++++++++;

;************************************************************************************************************************
;Program name: "itoa".  This program accepts a long integer and converts it to the corresponding string representation. *
;This is a library function not specific to any one program.  Copyright (C) 2018  Floyd Holliday                        *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public      *
;License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will  *
;be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR  *
;PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public License v3 is         *
;available here:  <https://www.gnu.org/licenses/>.                                                                      *
;************************************************************************************************************************

;Author information
;   Author name: Floyd Holliday
;   Author's email: holliday@fullerton.edu

;Function information
;   Function name: itoa
;   Programming language: X86
;   Language syntax: Intel
;   Function prototype:  char * itoa (long int x, char * numstring);
;   Reference: This function was adapted from Jorgensen, pages 154-156.
;   Input parameters: 1st: The integer that will be converted to string
;                     2nd: A pointer to memory where the converted integer will be written as string
;   Output parameter: Same value as the incoming second parameter.

;Future upgrade: Add a third incoming parameter which is the length of the destination string.  Such a
;parameter will allow this function to write no more chars than the true length of the destination.

;Assemble: nasm -f elf64 -o itoa.o -l itoa.lis itoa.asm

;Date development began: 2018-March-01
;Date comments restructured: 2022-July-15

;===== Begin executable code section ====================================================================================

;Declarations
global ltoa
Null equ 0
true equ -1
false equ 0

segment .data
;Empty

segment .bss
;Empty

segment .text

ltoa:

;Back up the GPRs
push       rbp                          ;Save a copy of the stack base pointer
mov        rbp, rsp                     ;We do this in order to be fully compatible with C and C++.
push       rbx                          ;Back up rbx
push       rcx                          ;Back up rcx
push       rdx                          ;Back up rdx
push       rsi                          ;Back up rsi
push       rdi                          ;Back up rdi
push       r8                           ;Back up r8
push       r9                           ;Back up r9
push       r10                          ;Back up r10
push       r11                          ;Back up r11
push       r12                          ;Back up r12
push       r13                          ;Back up r13
push       r14                          ;Back up r14
push       r15                          ;Back up r15
pushf                                   ;Back up rflags


;Passed parameters:
;  rdi = 64-bit integer to be converted to string
;  rsi = starting address of the string that will received the converted integer.

;Initialize parameters for iteration
mov rax,rdi    ;rax hold the 64-bit integer to be converted to string.
mov rcx,0      ;rcx = counter of decimal digits
mov r10,10     ;Decimal 10 must be in a register for the division instruction

;Special case: if the user inputs an integer numerically less than the smallest 64-bit signed integer
;then it will be upgraded to the smallest 64-bit integer.  The next block checks for this rather
;rare case and refuses to process it as an integer, and simply processes a zero.

mov r14,0x8000000000000000
cmp rax,r14
    jg continue
    mov rax,0

continue:
cmp rax,0
jge main_loop
    mov r15,true
    neg rax                   ;Replace rax with its absolute value

main_loop:
    cqo
    div r10                   ;rdx:rax/r10
    push rdx                  ;Put remainder on stack. The quotient is in rax
    inc rcx                   ;Count one push onto stack
    cmp rax,0                 ;Is quotient equal to zero?
jne main_loop                 ;Continue iteration if the quotient is not zero

;Initialize parameters for iteration that copies chars from stack to string
    ;rsi is the destination array
    ;rcx is the number of chars that will be placed into rsi
    mov rdi, 0                ;rdi will be the index of the array rsi

;If the original number was negative then place '-' in position 0 of the array.
    cmp r15,0
    je begin_copy             ;if original number was positive skip to begin_copy
    mov byte [rsi+rdi],'-'
    inc rdi

begin_copy:
    pop rax
    add al, "0"               ;Add to the numeric value in rax the ascii value of zero
    mov byte [rsi+rdi], al    ;Copy the ascii value of the digit to the array
    inc rdi
loop begin_copy               ;loop instruction performs: {dec rcx followed by if(rcx>0) then goto begin_copy}


mov byte [rsi+rdi],Null       ;Append null to the end of the string.

mov rax, rsi          ;Place the array into the return register

;Restore the GPRs to their original values
popf                                    ;Restore rflags
pop        r15                          ;Restore r15
pop        r14                          ;Restore r14
pop        r13                          ;Restore r13
pop        r12                          ;Restore r12
pop        r11                          ;Restore r11
pop        r10                          ;Restore r10
pop        r9                           ;Restore r9
pop        r8                           ;Restore r8
pop        rdi                          ;Restore rdi
pop        rsi                          ;Restore rsi
pop        rdx                          ;Restore rdx
pop        rcx                          ;Restore rcx
pop        rbx                          ;Restore rbx
pop        rbp                          ;Restore rbp
;Notice that rax is not restored because it holds the value to be returned to the caller.

ret
