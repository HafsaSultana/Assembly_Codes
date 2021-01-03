12577 - Hajj-e-Akbar
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data 
    x dw ?
    y dw 0
    i dw 1 
    
.code
main proc
    mov ax,@data
    mov ds,ax
    
    input_1:
        mov ah,1
        int 21h
        mov cl,al       ;for check inputs 1st digit
    input_2:
        int 21h
        cmp al,13
        jne  input_2    ;get input
        
        cmp cl,72       ;1st digit == H ?
        je pr_h
           
        cmp cl,85       ;1st digit == U ?
        je pr_u
        
        cmp cl,42       ;1st digit == * ?
        je end_         ;1st digit == * then break?
        
    pr_h:
        printn 
        print "Case "   ;for case print 
        mov ax,i
        call output
        print ": Hajj-e-Akbar"
        jmp exit
            
    pr_u:
        printn
        print "Case "   ;for case print
        mov ax,i
        call output
        print ": Hajj-e-Asghar"
        jmp exit
        
    exit:
        printn 
        inc i           ;for case i++
        jmp input_1 
           
    end_:
    mov ah,4ch
    int 21h
main endp

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