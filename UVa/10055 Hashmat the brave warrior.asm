;10055-Hashmat the brave warrior
include 'emu8086.inc'
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    a dw ?
     
    t dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    while:
    
    call input  
    mov a,ax        ;input a
    call input      ;input b 
    
    mov cx,0
    
    cmp ax,a        ;b>=a ?
    jle less        ;b<a
    jmp do
    
    do:
    sub ax,a        ;s=b-a
    call output
    jmp exit
    
    less:
        mov t,ax    ;temp=b
        mov cx,t
        mov ax,a    ;b=a
        mov a,cx    ;a=temp
        jmp do
 
    
   exit: 
    mov t,0
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
        
        cmp al,26
        je end_
        
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
    printn    
    ret
output endp 

end main