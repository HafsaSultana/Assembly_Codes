;11479 - Is this the easiest problem
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
    i dw 1
    t dw 0
    n dw 0
    mns db 0 
.code
main proc
    mov ax,@data
    mov ds,ax
    
    call input   
    add ax,1d
    mov n,ax 
    
    for:
        call input 
        mov a,ax 
        call input 
        mov b,ax
        call input 
        mov c,ax   
        
        mov cl,mns
        cmp cl,1
        je pr_in       ;(a<0 ||b<0 || c<0)
        mov cl,0
        
        mov ax,a
        cmp a,0
        je  pr_in
        
        mov ax,a
        cmp b,0
        je  pr_in
        
        mov ax,a
        cmp c,0
        je  pr_in      ;(a==0 ||b==0 || c==0)
        
        mov ax,a
        mov bx,b
        mov cx,c
        add ax,bx
        cmp ax,cx
        jle pr_in   
        
        mov ax,a
        add ax,cx
        cmp ax,bx
        jle pr_in 
        
        mov ax,a
        add bx,cx
        cmp bx,ax
        jle pr_in      ;(a+b<=c || a+c<=b ||b+c<=a)
        
        mov ax,a
        mov bx,b
        cmp ax,bx
        je and_
        
        mov ax,a
        mov cx,c
        cmp ax,cx
        je pr_is
        
        mov bx,b
        mov cx,c
        cmp bx,cx      ;(a==b || a==c ||b==c)
        je pr_is   
        
        jmp pr_sc      ;else
        
        
    and_:
        mov cx,c
        mov bx,b
        cmp cx,bx
        je pr_eq    ;(a ==b &&b == c)
        jmp pr_is
        
    pr_in:
        print "Case "
        mov ax,i
        call output
        print ": Invalid"
        jmp end_
        
    pr_is:
        print "Case "
        mov ax,i
        call output
        print ": Isosceles"
        jmp end_ 
        
    pr_eq:
        print "Case "
        mov ax,i
        call output
        print ": Equilateral"
        jmp end_
   
   pr_sc:
        print "Case "
        mov ax,i
        call output
        print ": Scalene"
        jmp end_        
    
    end_:
        printn
        mov mns,0
        inc i
        mov cx,i
        cmp cx,n 
        je exit
        jmp for 
           
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
    mov mns,1d
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