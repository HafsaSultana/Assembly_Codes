;382-Perfection
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    n dw ?
    i dw 0
    j dw 0
    k dw 0
    s dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
     print "PERFECTION OUTPUT" 
     printn
     
     while:
     call input
     mov n,ax
     
     cmp ax,0
     je exit
     
     mov s,0 
     mov i,1
     
     for:
        mov bx,i
        mov ax,n
        mov cx,2
        mov dx,0
        div cx
        cmp bx,ax       ;i<=(n/2)
        jg if
        
        mov ax,n
        mov cx,i
        mov dx,0
        div cx
        cmp dx,0        ;(n%i)==0?
        je sum
        
        inc i
        jmp for
        
     sum:
        mov ax,s
        mov cx, i
        add ax,cx
        mov s,ax
        inc i           ;s=s+i
        jmp for   
    
     if:
        mov ax,n
        mov bx,s
        cmp ax,bx
        je pr_p         ;s==n
        
        cmp bx,ax
        jl pr_d         ;s<n
        
        jmp pr_a        ;s>n
        
     pr_p:
        mov ax,n
        call output
        print "  PERFECT"
        printn
        jmp while
        
     pr_d:
        mov ax,n
        call output
        print "  DEFICIENT"
        printn
        jmp while
        
     pr_a:
        mov ax,n
        call output
        print "  ABUNDANT"
        printn
        jmp while
           
     
    exit: 
         print "END OF OUTPUT"
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