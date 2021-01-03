;1+2+3=6

.MODEL SMALL
.STACK 100H
.DATA 
;Variable Declare
    
   
.CODE ;Code Segment

MAIN PROC ;INT Main
    
    MOV AH , 1
    INT 21H
    SUB AL,48
    
    ;AL IS PRESENTED BY AX
    MOV AL,AL
    MOV AH,0       
    
    MOV DX,0    ;SUM=0
    MOV CX,0    ;i=0
    
    
    BACK:
    INC CX      ;i++
    ADD DX,CX   ;SUM=SUM+i
    CMP CX,AX   ;i=N?
    JNE BACK
    
    ADD  DX,48  ;FOR DICIMAL OUTPUT
    
    MOV BX,DX
    
    ;NEW LINE
    MOV AH,2
    MOV DX,10D
    INT 21H
    MOV DX,13D
    INT 21H
    
     
    MOV AH , 2
    MOV DX , BX
    INT 21H
                     
    MOV AH , 4CH
    INT 21H
    MAIN ENDP
END MAIN ;Return 0
       