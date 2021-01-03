;694 - The Collatz Sequence
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    a dw ?
    b dw ?
    p dw 0
    q dw 0
    c dw 0
    n dw 0
    i dw 1
    mns db 0
    
.code
main proc
    mov ax,@data
    mov ds,ax 
    
    while:
    
    call input 
    mov a,ax 
    mov p,ax            ;p=a 
    
    cmp ax,0
    jl end_
    
    call input          
    
    mov cl,mns
    cmp cl,1
    je end_
    mov cl,0
    
    mov b,ax 
    mov q,ax            ;q=b
    
    for:
        mov ax,a
        mov bx,b
        cmp ax,bx
        jle next        ;a<=b then go in loop 
        jmp exit
        
        next:
            inc c
            mov ax,a
            mov bx,1
            cmp ax,bx   ;a==1?
            je exit
            
            mov ax,a
            mov bx,2 
            mov dx,0
            div bx      ;a/2
            cmp dx,0    ;(a%2)==0?
            je else 
            
            mov ax,a
            mov bx,3    
            mul bx      ;3*a
            add ax,1d   ;3*a+1
            mov a,ax    ;a=3*a+1
            jmp for
            
        else:
            mov ax,a
            mov bx,2
            mov dx,0    ;a/2
            div bx
            mov a,ax    ;a=a/2
            jmp for
    
       exit:
        print "Case "
        mov ax,i        ;print case i
        call output
        print ": A = "  
        mov ax,p        ;print A= a
        call output
        print ", limit = "
        mov ax,q        ;print limit= b
        call output
        print ", number of terms = "
        mov ax,c        ;print number of terms c
        call output
        printn          ;print new line
        
        mov c,0
        inc i  
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