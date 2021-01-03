;136-Ugly Number
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data 

    str  db "1500th's ugly number is 859963392.$"
    
     
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,str
    int 21h
     
    mov ah,4ch
    int 21h
main endp

end main
