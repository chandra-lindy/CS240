; compare_two_floats
; CPSC 240 - Assingment #1
; by, Chandra Lindy

; open source license
; author info - 2 lines

; program information:
; name
; languages
; dates
; files
; status
; references

; purpose of this software
; module info
;; filename in os
;; language
;; how to compile
;; calls - does it call other functions?

; block structure for assembly

; ********** CODE BEGIN **********
extern    printf
extern    scanf
extern    isfloat
extern    atof
global    compare_two_floats

; Data segment - initialize dvariable sand ocnstants goes here
segment .data
; ********** DECLARATIONS **********

; message strings declarations
prompt_message                 db    "Please enter two float numbers separated by white space.  Press enter after the second input.", 10, 10, 0
confirmation_message           db    10, "These numbers were entered:", 10, "%1.16lf", 10, "%1.16lf", 10, 10, 0
comparison_result_message      db    "The larger number is %1.16lf", 10, 10, 0
bad_input_message              db    10, "An invalid input was detected.  You may run this program again.", 10, 0
return_message                 db    "This assembly module will now return execution to the driver module.", 10, "The smaller number will be returned to the driver", 10, 10, 0

; format strings declarations
string_f                       db    "%s", 0
float_f                        db    "%lf", 0

; constant numeric declarations
neg_1                          db    -0x1

; Text segment - instructions begin here, includes some headers or labels tha define inital program
; ********** EXECUTABLE CODE BEGIN **********
segment .text

compare_two_floats:

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

; ******************** program logic goes here ********************

; print input prompt message
mov       rax, 0
mov       rdi, prompt_message
call      printf

; get input from user for first string
sub       rsp, 1024             ; grow stack to handle string input
mov       rax, 0
mov       rdi, string_f
mov       rsi, rsp
call      scanf

; validate first string
mov       rax, 0
mov       rdi, rsp
call      isfloat
cmp       rax, 0
je        not_float

; convert first string to a float
mov       rax, 0
mov       rdi, rsp
call      atof
movsd     xmm14, xmm0

; get input from user for second string
mov       rax, 0
mov       rdi, string_f
mov       rsi, rsp               ; re-use top of stack since we no longer need first string
call      scanf

; validate second string
mov       rax, 0
mov       rdi, rsp
call      isfloat
cmp       rax, 0
je        not_float

; convert second string to float
mov       rax, 0
mov       rdi, rsp
call      atof
movsd     xmm15, xmm0
add       rsp, 1024              ; shrink stack to restore

; print confirmation message
mov       rax, 2
mov       rdi, confirmation_message
movsd     xmm0, xmm14
movsd     xmm1, xmm15
call      printf

; compare floats
ucomisd   xmm14, xmm15
jl        lessThan

; else swap positions
movsd     xmm13, xmm14
movsd     xmm14, xmm15
movsd     xmm15, xmm13

lessThan:
; display comparison result
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
; display bad input message
mov       rax, 0
mov       rdi, bad_input_message
call      printf
add       rsp, 1024

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
