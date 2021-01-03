;13012 - Identifying tea.
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    n dw ?
    p dw ? 
    r dw 0 
    i dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    while:
    call input
    mov n,ax            ;input n               
    
    mov i,0
    for:
        mov ax,i        ;i<5
        mov cx,5
        cmp ax,cx
        jge pr
        
        call input      ;input p
        mov p,ax
        
        mov bx,n 
        mov cx,p        ;p==n?
        cmp cx,bx
        je if
        inc i           ;i++
        jmp for
    
    if:
    inc r               ;p++
    inc i
    jmp for
        
    pr:
        mov ax,r
        call output
        printn
        mov r,0
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
        
        cmp al,26
        je exit
        
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