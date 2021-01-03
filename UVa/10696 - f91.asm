;10696 - f91
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    n dw ?
    i dw 0
    k dw 0
.code
main proc
    mov ax,@data
    mov ds,ax 
    
    while:
    
    call input 
    mov n,ax        ;input n 
    
    mov bx,n
    cmp bx,0        ;n==0 ?   
    je end_         ;if n==0 then go end
    
    mov cx,101d     ;cx=101
    cmp bx,cx       ;n>=101 ?
    jge end_1       ;n>=101 then go end_1
    
    mov cx,100d     ;cx=100
    cmp bx,cx       ;n<=100 ?
    jle end_2       ;n<=100 then go end_2
    
    end_1:
        mov cx,10
        mov bx,n
        sub bx,cx   ;n-10
        mov k,bx    ;k=n-10
        
        print "f91("
        mov ax,n
        call output
        print ") = "
        mov ax,k
        call output   ;f91( n ) = k
        printn 
        jmp exit
     
    end_2:
        mov cx,91
        mov k,cx      ;k=91
        
        print "f91("
        mov ax,n
        call output
        print ") = "
        mov ax,k
        call output  ;f91( n ) = k
        printn
        jmp exit
   
    exit: 
        jmp while
    
    end_:            ;end programe
   
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