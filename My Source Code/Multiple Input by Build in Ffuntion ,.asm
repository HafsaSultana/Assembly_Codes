include 'emu8086.inc'
.model small
.stack 100h
.data

num1 dw ?
num2 dw ?

.code

mov ax,@data
mov ds,ax

xor ax,ax

input:

call   scan_num       ; get number in CX.
mov num1,cx

printn

call   scan_num       ; get numbe r in CX.
mov num2,cx

output:

printn
mov ax,num1
call   print_num      ; print number in AX 

printn
mov ax,num2
call   print_num
printn


exit:
mov ah,4ch
int 21h

ret               ; return to operating system.

; required for print_num.
define_scan_num 

; required for print_num.
define_print_num
define_print_num_uns  

