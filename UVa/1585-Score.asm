;1585-Score
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    s db ?
    t dw ? 
    i dw 0
    c dw 0
    k dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    call input
    mov t,ax            ;input t               
    
    while:
    mov ax,t
    cmp ax,0            ;compare test case
    je exit
    
    mov i,0
    for: 
        mov ah,1
        int 21h
        
        cmp al,13
        je pr
        
        mov s,al
        
        cmp al,"o"       ;s== "o" then c++
        je if
        
        mov c,0          ;else c=0
        jmp sum
    
    if:
        inc c
        jmp sum          ;c++
        
    sum:
        mov ax,k
        mov bx,c
        add ax,bx
        mov k,ax        ;k=k+c
        jmp for    
    
    pr: 
        printn
        mov ax,k
        call output     ;print k
        printn          
        mov c,0
        mov k,0
        dec t
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