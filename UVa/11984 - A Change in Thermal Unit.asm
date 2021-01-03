;11984 - A Change in Thermal Unit
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    c dw ?
    d dw ?
    f dw 0
    i dw 1
    n dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    call input
    add ax,1d
    mov n,ax
    
    while:
    call input
    mov c,ax 
    call input
    mov d,ax 
    
    mov cx,9
    mov ax,c
    mul cx
    mov cx,5
    div cx
    mov cx,32
    add ax,cx  
    mov f,ax        ;f=((9*c)/5)+32;
    
    mov ax,f
    mov bx,d
    add ax,bx
    mov f,ax        ;f=f+d
    
    mov cx,32
    mov ax,f
    sub ax,cx
    mov cx,5
    mul cx
    mov cx,9
    div cx
    mov c,ax        ;c=(5*(f-32))/9;
    
    print "Case "
    mov ax,i
    call output
    print ": "  
    mov ax,c
    call output 
    printn
    
    inc i
    mov cx,i
    cmp cx,n
    je end_
    jmp while
    
    end_:
    mov ah,4ch
    int 21h
main endp


input proc
    mov bx,0
    
    get_input:
        mov ah,1
        int 21h
        cmp al,13
        jne number
        mov ax,bx
        jmp end
        
    number:
        sub al,48
        mov ah,0
        mov x,ax
        mov ax,bx
        mov cx,10
        mul cx
        
        ;mov dx,0 
        add ax,x
        mov bx,ax
        jmp get_input
        
    end:
        printn
        ret
input endp 

output proc
       mov y,0 
    level:
        mov dx,0
        mov cx,10
        div cx
        push dx
        inc y
        cmp ax,0
        je incre
        jmp level
        
    incre: 
     ;printn
        mov cx,y
        jmp printf
        
    printf:
        mov ah,2
        pop dx
        add dx,48
        int 21h
        loop printf
    ret
output endp 

end main