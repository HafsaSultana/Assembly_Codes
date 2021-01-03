INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H
.DATA 
;Variable Declare
    
   
.CODE ;Code Segment

    MAIN PROC ;INT Main
        
        ;;UNConditional
        ;START:
        ;PRINTN "LOVE"
        ;JMP START
        
        ;Conditional
        MOV BX , 0 ; Initializa ; i=0 
        MOV CX , 5 ; Given ; n
        
        ;For(i=0 ; i<n ;i++)
        
        START:
        CMP BX , CX ; Condition check ; i<n ; BX < CX
        JE LAST
        PRINTN "LOVE"
        INC BX
        JNE START
        
        LAST:
        PRINTN "The program is ended"
                    
        MOV AH , 4CH
        INT 21H
    MAIN ENDP
END MAIN ;Return 0
       