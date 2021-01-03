;11185 - Ternary
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    n dw ?
    a dw 0
    i dw 0 
    mns db 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    while:
    
    call input 
    mov n,ax       
    
    mov cl,mns  
    cmp cl,1
    je exit
    mov cl,0
   
    cmp ax,0        ;n==0?
    je end_0        ;if n==0 ptint 0
    jmp for
    
    for:
        mov ax,n    
        mov bx,3
        mov dx,0
        div bx      ;n/3
        mov a,dx    ;a=(n%3) 
        mov n,ax    ;n=n/3  
        
        mov dx,a
        push dx     ;push[a]
       
        inc i       ;i++
        mov a,0     ;a=0
        
        mov cx,n
        cmp cx,0
        je f
        jmp for
    
    f:
        mov ah,2
        pop dx
        add dx,48
        int 21h
       
        dec i 
        mov cx,i
        cmp cx,0
        je end_
        jmp f
        
   
    end_0:
    print "0"
    
    end_:
        printn
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
        
        cmp al,"-"
        je mainus
        
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
        
    mainus:
        mov mns,1
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