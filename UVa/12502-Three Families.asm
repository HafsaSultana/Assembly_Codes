;12502-Three Families
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
    p dw 0
    q dw 0 
    r dw 0
    s dw 0
    t dw 0
    i dw 0
    n dw 0
.code
main proc
    mov ax,@data
    mov ds,ax 
    
    call input
    mov t,ax
    
    while:
    
    call input 
    mov a,ax        ;input a 
    
    call input 
    mov b,ax        ;input b
    
    call input 
    mov c,ax        ;input c
    
    mov ax,a
    mov bx,b 
    add ax,bx       ;a+b 
    mov cx,3
    div cx          ;(a+b)/3
    mov s,ax        ;s=(a+b)/3   
    
    mov ax,a
    mov bx,s
    sub ax,bx       ;a-s
    mov p,ax        ;p=a-s
    
    mov ax,b
    mov bx,s
    sub ax,bx       ;b-s
    mov q,ax        ;q=b-s 
    
    mov ax,p
    mov bx,q
    add ax,bx       ;p+q
    mov r,ax        ;r=p+q
    
    mov ax,p
    mov bx,c
    mul bx          ;p*c
    mov cx,r
    div cx          ;(p*c)/r
    mov n,ax        ;n=(p*c)/r
    call output
    
    dec t 
    mov cx,t
    cmp cx,0
    je end_ 
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