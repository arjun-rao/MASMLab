assume cs:code

code segment
start:
     MOV AH,01
     INT 21H
     CMP AL,'G'
     JNE LAST
     MOV AH, 0
     MOV AL, 02
     INT 10H
     MOV AH,09
     MOV BH, 0
     MOV BL,22H
     MOV CX,2000
     INT 10H
LAST:
       mov ah,4ch
       int 21h
code ends
end start

