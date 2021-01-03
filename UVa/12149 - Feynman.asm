;12149 - Feynman
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    n dw ?
    t dw 0
    i dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    while:
    
    call input 
    mov n,ax 
    
    cmp ax,0
    je exit
    
    mov  i,0
    for:
       mov ax,n
       mov cx,i
       cmp cx,ax
       jge pr
       
       add cx,1d  
       mov ax,cx
       mul cx        ;(i+1)*(i+1)
       mov bx,t
       add ax,bx
       mov t,ax       ;t=t+(i+1)*(i+1) 
       inc i          ;i++
       jmp for
       
    pr:
        mov ax,t
        call output
        printn
        mov t,0
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