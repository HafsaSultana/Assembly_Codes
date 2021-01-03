                                         .MODEL SMALL
.STACK 100H
.DATA 
;Variable Declare
    
   
.CODE ;Code Segment

MAIN PROC ;INT Main
    
    MOV AH , 1
    INT 21H
            ;The input is stored in "AL" Register
    
   
    MOV AH , 2
    MOV DL , AL
    INT 21H
                     
    MOV AH , 4CH
    INT 21H
    MAIN ENDP
END MAIN ;Return 0
       