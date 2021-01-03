.MODEL SMALL
.STACK 100H
.DATA
   R DW 48
   C DW 48
   CHAR DB '*'
.CODE
MAIN PROC
     
    MOV AX,@DATA
    MOV DS,AX
     
    ;INPUT ROW
    MOV AH,1
    INT 21H
    SUB AL,48
     
    MOV AL,AL
    ;MOV AH,0H 
    XOR AH,AH
    
    MOV R,AX      ;input row
    
    ;INPUT COLUMN
    MOV AH,1
    INT 21H
    SUB AL,48
    
    MOV AL,AL
    ;MOV AH,0H    
    XOR AH,AH
                  
    MOV C,AX      ;input clmn
    
    ;Print new line
    MOV AH , 2
    MOV DX , 0AH
    INT 21H 
    MOV DX , 0DH
    INT 21H
       
    MOV CX,0       ;i=1
    
    OUTER:
    MOV BX,0       ;j=1         
    
    INNER:
    ;Print *
    MOV AH,2
    MOV DL,CHAR
    INT 21H
    
    INC BX         ;j++
    CMP BX,C       ;j<clmn
    JNE INNER
    ;Print new line
    MOV AH , 2
    MOV DX , 0AH
    INT 21H 
    MOV DX , 0DH
    INT 21H
    
    INC CX         ;i++
    CMP CX,R       ;i<ROW
    JNE OUTER   
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN