.MODEL SMALL
.STACK 100H
.DATA

.CODE
MAIN PROC
    
    MOV AL,3
    MOV BL,2
    
    MUL BL
    
    ADD AL,48
    
    MOV AH,2                         
    MOV DL,AL
    INT 21H
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
