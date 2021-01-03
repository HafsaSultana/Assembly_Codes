;10018-Reverse and Add
include 'emu8086.inc' 
org 100h
.model small
.stack 100h
.data
    x dw ?
    y dw 0 
    n dw ?
    i dw 0
    t dw 0
    r dw 0
    j dw 0
    s dw 0
    b dw 0
    k dw 0
.code
main proc
    mov ax,@data
    mov ds,ax
    
    call input
    mov k,ax            ;input test case k
    
    while:
    
    call input 
    mov n,ax            ;input n
    mov b,ax            ;b=n
    
    for:
        mov ax,n
        mov t,ax        ;t=n
        f:
          mov ax,r
          mov cx,10
          mul cx
          mov bx,ax     ;r*10
          
          mov ax,t
          mov cx,10
          mov dx,0
          div cx        ;t%10
          
          add bx,dx
          mov r,bx      ;r=(r*10)+(t%10)
          
          mov ax,t
          mov cx,10
          mov dx,0
          div cx
          mov t,ax      ;t=t/10
          
          cmp ax,0      ;t==0?
          je if
          jmp f         ;t!=0 then go f
              
    if:                 ; if(n==r && r!=b)
      mov ax,n
      mov bx,r
      cmp ax,bx         ;n==r?
      je and_           ;n==r then go and
      jmp next          ;n!=r then go next
      
    and_:
      mov ax,b          
      mov bx,r
      cmp ax,bx         ;r==b?  
      je next           ;r==b then go next
      
      mov ax, j         
      call output       ;print j
      print " "
      mov ax, n         ;print n
      call output 
      printn            ;print new line
      mov j,0
      mov s,0
      mov r,0
      mov n,0
      mov t,0 
      jmp exit 
   
   next:
       mov ax,n
       mov bx,r
       add ax,bx    ;n+r
       mov s,ax     ;s=n+r
       mov n,ax     ;n=s
       inc j        ;j++
       mov r,0      ;r=0
       jmp for
      
   exit:
        dec k
        mov cx,k
        cmp cx,0
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