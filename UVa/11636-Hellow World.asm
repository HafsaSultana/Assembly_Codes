;11636-Hello World    
include 'emu8086.inc'
org 100h
.model small 

.stack 100h
.data
    x dw ?
    y dw 0 
    a dw ?
    b dw ? 
    s dw 1
    i dw 0
    n dw 0  
    mns db 0 
    t dw 1
    
.code
main proc
    mov ax,@data
    mov ds,ax
     
    while:  
    call input 
    
    mov cl,mns
    cmp cl,1         ;n<0 then go end the programe
    je end_  
    
    for:  
        mov n,ax 
        mov cx,0
        mov bx,0
    
    f: 
      mov cx,s
      mov bx,n
      cmp cx,bx      
      jnl exit       ;s<n then exit 
      jmp hello
       
    
    hello:
    
        mov bx,2
        mov ax,s
        mul bx
        mov s,ax     ;s=2*s
        inc i        ;i++
        jmp f
        
             
    exit: 
    print "Case "
    mov ax,t
    call output
    inc t
    print ": "
    mov ax,i
    call output   
    printn
    
    mov i,0
    mov s,1
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
     
     MOV Y,0
        
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