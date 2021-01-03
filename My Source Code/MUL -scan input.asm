.MODEL SMALL
.STACK 100H
.DATA

.CODE
MAIN PROC
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MOV BL,AL
    
    MOV AL,1
    INT 21H
    SUB AL,48
    
    MUL BL
    
    MOV CL,AL
    ADD CL,48
    
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
     
    MOV AH,2                         
    MOV DL,CL
    INT 21H
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
