;13025 - Back to the Past
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    
.code
main proc
    mov ax,@data
    mov ds,ax
    
    printn "May 29, 2013 Wednesday"
    
    mov ah,4ch
    int 21h
main endp

end main