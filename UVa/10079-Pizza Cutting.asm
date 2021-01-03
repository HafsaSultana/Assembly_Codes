;10079-Pizza Cutting
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    n dw ?
    i dw 2
    k dw 2 
    mns db 0
.code
main proc
    mov ax,@data
    mov ds,ax 
    
    while:
        mov i,2     ;i=2
        mov k,2     ;k=2
        
    call input 
    
    mov cl,mns
    cmp cl,1
    je end_
    mov cl,0
    
    add ax,1d 
    mov n,ax        ;input n 
    
    cmp ax,0        ;n==0?
    je end_1        ;n==0 thn print 1
    jmp for
    
    for:
        mov ax,i    
        mov bx,k
        add ax,bx   ;i+k
        mov k,ax    ;k=i+k
        inc i       ;i++
        mov cx,i
        cmp cx,n    ;i<=n 
        je end_2
        jmp for    
        
    
    end_1:
        print "1" 
        jmp exit  
        
    end_2:
        mov ax,k    ;print k
        call output
         
    exit:
        printn
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