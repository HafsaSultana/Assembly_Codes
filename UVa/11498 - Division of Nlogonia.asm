;11498 - Division of Nlogonia
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    a dw ?
    b dw ?
    p dw ?
    q dw ?
    n dw ?
    k dw 0
    i dw 0
    j dw 0
    
.code
main proc
    mov ax,@data
    mov ds,ax
    
    while:
    call input 
    mov n,ax        ;input n
    
    cmp ax,0
    je exit         ;n==0?
    
    call input 
    mov p,ax        ;input p
    
    call input 
    mov q,ax        ;input q
    
    mov i,0
    for:
        mov bx,i
        cmp bx,n
        jl  f       ;i<n then go loop
        jmp end_ 
        
        f:
          call input 
          mov a,ax       ;input a
    
          call input 
          mov b,ax       ;input b 
          
          mov ax,a
          mov bx,p
          cmp ax,bx      ;a==p?
          je  p_di
          
          mov ax,b
          mov bx,q
          cmp ax,bx      ;b==q?
          je  p_di 
          
          mov ax,a
          mov bx,p
          cmp ax,bx      ;a>p
          jg  if_1
           
          mov ax,b       ;a<p
          mov bx,q
          cmp ax,bx      ;b>q
          jg  p_no       ;a<p && b>q   
          
      f_1:
          mov ax,a
          mov bx,p
          cmp ax,bx      ;a>p
          jg  if_2
           
          mov ax,b       ;a<p
          mov bx,q
          cmp ax,bx      ;b<q
          jl  p_so       ;a<p && b<q 
          
          
          
    
    if_1:
         mov ax,b       
         mov bx,q
         cmp ax,bx      ;b<q
         jg  p_ne       ;a>p && b>q
         jmp f_1  
         
    if_2:
         mov ax,b       
         mov bx,q
         cmp ax,bx      ;b<q
         jl  p_se       ;a>p && b<q 
         jmp end_ 
              
    
    p_di:
        print "divisa"
        jmp end_    
    
    p_ne:
        print "NE"
        jmp end_  
    
    p_no:
        print "NO"
        jmp end_ 
        
    p_se:
        print "SE"
        jmp end_     
    
    p_so:
        print "SO"
        jmp end_ 
         
    end_:
    printn
    dec n           ;n--
    mov cx,n
    cmp cx,0
    jE while
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


end main