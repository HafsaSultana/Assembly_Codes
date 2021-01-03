INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA
    A DB ?
    C DB ?

.CODE
MAIN PROC
    ;MOV CL,48
    ;MOV DL,48
    
    PRINTN "INPUT : "
    
    INPUT:
    MOV AH,1
    INT 21H
    CMP AL,0DH
    JE END_INPUT
    MOV CL,AL
    MOV AL,10
    MUL DL
    ADD AL,CL
    MOV DL,AL
    JMP INPUT
    
    PRINTN "OUTPUT : "
     
     xor cx,cx
     mov cl,c
     
     mov 10
     xor ah,ah
     mov al,n
    
    OUTPUT:
    DIV BL
    XOR DX,DX
    MOV AL,DH
    ADD DL,48
    PUSH DX
    loop output
    
    
    
    END_INPUT:
     
    ;MOV AH,2                         
    ;MOV DL,CL
    ;INT 21H
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
