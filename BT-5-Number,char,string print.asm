.MODEL SMALL
.STACK 100H
.DATA 
;Variable Declare
      
      NUM DB 49
      CHAR DB 'A'
      MSG DB "My name is Hafsa. $"
      MGS DB "I love country. $"
      
.CODE ;Code Segment

MAIN PROC ;INT Main
    
    MOV AX , @DATA
    MOV DS , AX
    
    MOV AH , 2
    MOV DL , NUM
    INT 21H      ;Print number
    
    MOV AH , 2
    MOV DL , 0AH
    INT 21H 
    MOV DL , 0DH
    INT 21H      ;Print new line
    
    MOV AH , 2
    MOV DL , CHAR
    INT 21H       ;Print char 
    
    MOV AH , 2
    MOV DL , 0AH
    INT 21H 
    MOV DL , 0DH
    INT 21H      ;Print new line
    
    MOV AH , 9
    LEA DX , MSG
    INT 21H       ;Print String 
                 
    MOV AH , 2
    MOV DL , 0AH
    INT 21H 
    MOV DL , 0DH
    INT 21H      ;Print new line
    
    MOV AH , 9
    LEA DX , MGS
    INT 21H       ;Print String 
                 
                 
    MOV AH , 4CH
    INT 21H
    MAIN ENDP
END MAIN ;Return 0
       