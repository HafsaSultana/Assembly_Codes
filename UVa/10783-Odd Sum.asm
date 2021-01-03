;10783-Odd Sum
include 'emu8086.inc'
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    a dw ?
    b dw ? 
    s dw 0
    i dw 0
    j dw 0
    t dw 1
.code
main proc
    mov ax,@data
    mov ds,ax 
    
    call input 
    add ax,1d     ;for t start of 1 
    mov j,ax      ;j=test case
    
    
    
    while:
    ;mov cx,0
    call input  
    mov a,ax        ;input a
    mov i,ax        ;i=a
    call input
    ;add ax,1d
    mov b,ax        ;input b
    
    cmp ax,a        ;b>a?
    jl temp         ;b<a then go to temp
    jmp for
    
    for:
    mov ax,b
    add ax,1d       ;b=b+1 for i
    mov b,ax
    jmp f
    
    f:
     
     mov ax,i       ;  
     mov bx,2 
     mov dx,0
     div bx         ;i/2
     cmp dx,0       ;(i%2 )==0 ?
     jne odd        ;if != ,go to odd
     jmp incr
     incr:
     inc i          ;i++
     mov cx,i       
     cmp cx,b       ;i==b ? 
     je exit        ;if == then go to exit
     jmp f
     
     
     odd:
        mov ax,s    
        mov bx,i
        add ax,bx   ;s+i
        mov s,ax    ;s=s+i
        jmp incr
    
    temp:
    mov bx,a
    mov cx,b
    mov a,cx
    mov b,bx  
    mov i,cx        ;i=a
    jmp for
             

    exit: 
    print "Case "
    mov ax,t
    call output
    print ": "
    mov ax,s
    call output     ;print sum
    
    mov s,0         ;s=0
    printn
    inc t           ;t++
    mov cx,t
    cmp cx,j        ;t==j(test case)?
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