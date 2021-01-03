;11805 - Bafana Bafana
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
    n dw 0 
    i dw 0
    s dw 0
.code
main proc
    mov ax,@data
    mov ds,ax 
    
    call input 
    mov n,ax 
    
    mov i,1
    
    for:
        mov bx,i
        mov cx,n
        cmp bx,cx
        jg exit:
    
        call input 
        mov a,ax 
        call input 
        mov b,ax  
        call input 
        mov c,ax 
        
        dec b        ;b--
        
        mov bx,b
        mov cx,c
        add bx,cx    ;b+c
        mov ax,bx
        mov cx,a
        mov dx,0
        div cx
        add dx,1d    ;((b+ c) % a) + 1
        mov s,dx     ;s=((b+ c) % a) + 1 
        
        print "Case "
        mov ax,i
        call output
        print ": "
        mov ax,s
        call output  ;Case i: s
        printn
        mov s,0
        inc i        ;i++
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