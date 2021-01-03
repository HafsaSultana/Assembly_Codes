;12372 - Packing for Holiday
include 'emu8086.inc'
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    l dw ?
    w dw ? 
    h dw ? 
    n dw 0
    i dw 1
.code
main proc
    mov ax,@data
    mov ds,ax
    
    call input 
    add ax,1d 
    mov n,ax
    
    while:
    
    call input  
    mov l,ax        ;input l         
    
    call input  
    mov w,ax        ;input w 
     
    call input  
    mov h,ax        ;input h 
    
    mov cx,20
    mov bx,l        
    cmp bx,cx       ;l>20 ?
    jg end_1        ;l>20 then print bad
    
    mov bx,w 
    cmp bx,cx       ;w>20 ?
    jg end_1        ;w>20 then print bad
    
    mov bx,h 
    cmp bx,cx       ;h>20 ?
    jg end_1        ;h>20 then print bad
    jmp end_2       ;else print good
    
    
    end_1:
        print "Case "
        mov ax,i
        call output
        print ": "
        printn "bad" 
        jmp exit
    
    end_2:
        print "Case "
        mov ax,i
        call output
        print ": "
        printn "good"  
         
    exit:  
        inc i 
        mov cx,i
        cmp cx,n
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