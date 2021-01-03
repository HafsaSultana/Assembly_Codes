;11689 - Soda Surpler
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    a dw ?
    b dw ? 
    c dw ?
    s dw 0
    i dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    call input 
    mov i,ax 
    
    while:
    
    call input 
    mov a,ax 
    call input 
    mov b,ax 
    call input 
    mov c,ax 
    
    mov ax,a
    mov bx,b
    add ax,bx
    mov a,ax        ;a=a+b
    
    for:
        mov ax,a
        mov cx,c
        cmp ax,cx
        jl pr
        
        mov dx,0
        div cx
        add ax,s
        mov s,ax     ;s+=a/c  
        
        mov ax,a
        mov cx,c
        mov dx,0
        div cx
        add ax,dx
        mov a,ax
        jmp for
        
    pr:
        mov ax,s
        call output 
        printn
        mov s,0
        dec i
        mov cx,i
        cmp cx,0
        je exit:
        jmp while
            
    exit:    
    
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