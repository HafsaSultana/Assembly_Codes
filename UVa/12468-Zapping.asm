;12468-Zapping
include 'emu8086.inc'
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    a dw ?
    b dw ? 
    m dw 0
    n dw 0
    mns db 0
    
.code
main proc
    mov ax,@data
    mov ds,ax 
    
    while:
    
    call input  
    mov a,ax        ;input a  
    
    call input
    mov b,ax        ;input b 
    
    mov cl,mns
    cmp cl,1
    je  exit        ;for mainus input go exit
    mov cl,0
    
    cmp ax,a        ;b>a?
    jng temp         ;b<a then go to temp
    jmp for
    
    for:
        mov ax,a    
        mov bx,b
        sub bx,ax   ;b-a
        mov m,bx    ;m=b-a
        
        mov cx,100
        mov bx,b
        sub cx,bx   ;100-b
        add cx,ax   ;(100-b)+a
        mov n,cx    ;n=(100-b)+a
        
        mov bx,m
        mov cx,n
        cmp bx,cx   ;m<n?
        jle end_1   ;if m<n then go end_1
        jmp end_2   ;if m>n then go end_2
        
    
    temp:
        mov bx,a
        mov cx,b
        mov a,cx        ;a=b
        mov b,bx        ;b=a
        jmp for  
             
    end_1:
        mov ax,m
        call output
        jmp end_  
    
    end_2:
        mov ax,n
        call output    
    
    end_: 
        printn
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