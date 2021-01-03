;12992 - Huatuo's Medicine
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    t dw ?
    n dw ?
    i dw 1
    s dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    call input 
    mov t,ax         ;input test case
    
    while:
        mov ax,t
        mov bx,i      ;check test case
        cmp bx,ax
        jg exit
        
        call input    ;input n
        mov n,ax
        
        mov ax,n
        mov cx,2
        mul cx
        sub ax,1d     
        mov s,ax      ;s=n*2-1
        
        print "Case #"
        mov ax,i
        call output
        print ": "
        mov ax,s
        call output
        printn
        inc i          ;i++
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