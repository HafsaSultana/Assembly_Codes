.MODEL SMALL
.STACK 100H
.DATA 
;Variable Declare
    
    A DB ?
    B DB ? 
      
.CODE ;Code Segment

MAIN PROC ;INT Main
    
    MOV AH , 1
    INT 21H
            ;The input is stored in "AL" Register
    
    MOV A , AL
    SUB A , 48 ; A=A-48 
    
    INT 21H
    
    MOV B , AL
    SUB B , 48 ; B=B-48 
    
    MOV BH , A  ;BH= A
    ADD BH , B  ;BH= BH + B 
    ADD BH , 48 ;BH= BH + 48
    
    
    MOV AH , 2
    MOV DL , 0AH
    INT 21H
    MOV DL , 0DH
    INT 21H
    
    MOV AH , 2
    MOV DL , AL
    INT 21H
    
    MOV DL , BH
    INT 21H
                     
    MOV AH , 4CH
    INT 21H
    MAIN ENDP
END MAIN ;Return 0
       