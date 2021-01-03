;11877 - The Coco-Cola Store
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    n dw ?
    c dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    while:
    call input          ;input n
    mov n,ax 
    
    cmp ax,0            ;n==0 then go end
    je end_
         
    for:
        mov cx,3
        mov n,ax 
        cmp ax,cx       ;n>=3
        jl if 
        
        sub ax,cx
        mov n,ax        ;n=n-3
        inc c           ;c++
        add ax,1d      
        mov n,ax        ;n=n+1
        jmp for
        
    if:
        mov ax,n
        cmp ax,2        ;n==2?
        je in_if
        jmp else
    in_if:
        inc c           ;c++
        mov ax,c
        call output     ;print c   
        mov c,0
        printn
        jmp while
        
    else:
        mov ax,c
        call output     ;print c
        mov c,0
        printn
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