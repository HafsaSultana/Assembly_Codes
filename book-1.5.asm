.model smell
.stack 100h 
.data
a dw 2
b dw 5
sum dw ?
.code
    main proc
    mov ax,@data
    mov ds,ax
    mov ax,a
    add ax,b
    mov sum,ax
    mov ax,4c00h
    int 21h
main endp
    end main

