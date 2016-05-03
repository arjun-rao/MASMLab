assume ds:data,cs:code
data segment
       scode db ?
       row db ?
       col db ?
       pa equ 20a0h
       pb equ 20a1h
       pc equ 20a2h
       cr equ 20a3h 
       table db 0, 0 ,8, 10h
       
        
data ends

code segment

start:
        mov ax, data
        mov ds,ax

        mov dx,cr
        mov al,90h
        out dx,al

repeat: mov bl, 04
        mov bh, 03

next_row: mov dx, pc
          mov al, bl
        out dx, al

        mov dx, pa
        in al, dx

        cmp al, 00h
        JNE GO_AHEAD
        shr bl, 1
        dec bh
        JNZ NEXT_ROW
        jmp repeat

go_ahead:mov row, bh
        mov ah, 1

rot:    ror al, 1
        JC NEXT
        inc ah
        JMP ROT

next:   mov col, ah
        lea si, table
        mov bl, row
        mov bh, 00
        mov al, [si][bx]
        add al, col
        mov scode, al

        mov ah,2
        mov dl, row
        add dl, 30h
        int 21h

        mov ah, 2
        mov dl,' '
        int 21h

        mov ah, 2
        mov dl, col
        add dl, 30h
        int 21h

        mov ah, 2
        mov dl, ' '
        int 21h

        mov al, scode
        aam
        add ax, 3030h
        mov bx, ax

        mov dl, bh
        mov ah, 2
        int 21h

        mov dl, bl
        mov ah, 2
        int 21h


                
        mov ah,4ch
        int 21h
  code ends
  end start
