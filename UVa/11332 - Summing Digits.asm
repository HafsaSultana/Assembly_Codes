;11332 - Summing Digits 
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
    r dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    while:
     call input 
     mov n,ax           ;input n 
     
     cmp ax,0           ;n==0?
     je end_            ;n==0 then go end
     jmp f
    
       f:
         mov ax,n
         mov bx,10
         mov dx,0       ;n/10
         div bx
         mov cx,dx      ;n%10
         add r,cx       ;r+=(n%10)
      
         mov n,ax       ;n=n/10
         cmp ax,0       ;n==0?
         je if          ;n==0 then go if
       jmp f
         
         if:
            mov bx,r    
            cmp bx,10   
            jl exit     ;r<10?
         jmp else
            
         else:
            mov cx,r
            mov n,cx    ;n=r
            mov r,0     ;r=0
         jmp f
         
         exit:
            mov ax,r
            call output ;print r
            printn  
            mov r,0     ;r=0
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