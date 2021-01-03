;11172 - Relational Operator
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    a dw ?
    b dw ?
    n dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    call input
    mov n,ax
    
    while:
    call input 
    mov a,ax 
    call input 
    mov b,ax 
    
    mov cx,a
    mov bx,b
    cmp cx,bx
    jg  end_1
    
    cmp cx,bx
    jl  end_2
    
    cmp cx,bx
    je  end_3
    
    
    end_1:
        print ">"
        jmp exit
        
    end_2:
        print "<"
        jmp exit  
        
    end_3:
        print "="
    
    exit:
        printn
        dec n 
        mov cx,n
        cmp cx,0
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