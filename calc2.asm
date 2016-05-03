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
       op1 db ?
       op2 db ?
       opr db ?
       plus equ 0Ch
       minus equ 0Dh
       result db ?
        
data ends

code segment

start:
        mov ax, data
        mov ds,ax       
        mov dx,cr
        mov al,90h
        out dx,al

repeat_comp:
        mov dl,0ah
        mov ah,02
        int 21h
        mov dl,0dh
        mov ah,02
        int 21h
        mov opr, 0
        call inkey  ;op1
        call delay
        mov al,scode
        dec al
        mov op1,al
        call display

        call inkey; operation
        call delay
 

        cmp scode,plus
        jz plus_code
        cmp scode,minus
        je minus_code
        jmp done

   plus_code:
        mov dl,'+'
        mov ah,02
        int 21h
        mov opr,1
        call inkey; op2
        call delay
        mov al,scode
        dec al
        mov op2,al
        call display;
        mov al, op1
        add al,op2
        mov result,al
        jmp done
   minus_code:
        mov dl,'-'
        mov ah,02
        int 21h
        mov opr,1
        call inkey; op2
        call delay
        mov al,scode
        dec al
        mov op2,al
        call display;
        mov al, op1
        sub al,op2
        mov result,al
        jmp done

   done:
         cmp opr,0
         jz ending
         mov dl,'='
         mov ah,02
         int 21h
         mov al,result
         call display
         jmp repeat_comp;
  ending:             
        mov ah,4ch
        int 21h



inkey proc
        push ax
        push bx
        push cx
        push dx

repeat: mov bl, 04
        mov bh, 03

next_row: mov dx, pc
          mov al, bl
          out dx, al

          mov dx, pa
          in al, dx

        cmp al, 00h
        JNE go_ahead
        shr bl, 1
        dec bh
        JNZ next_row
        jmp repeat

go_ahead:mov row, bh
        mov ah, 1

rot:    ror al, 1
        JC next
        inc ah
        jmp rot

next:   mov col, ah
        lea si, table
        mov bl, row
        mov bh, 00
        mov al, [si][bx]
        add al, col
        mov scode, al
        pop dx
        pop cx
        pop bx
        pop ax
        ret
inkey endp



display proc
        push ax
        push bx
        push cx
        push dx

        aam
        add ax, 3030h
        mov bx, ax

        mov dl, bh
        mov ah, 2
        int 21h

        mov dl, bl
        mov ah, 2
        int 21h

        pop dx
        pop cx
        pop bx
        pop ax
        ret
display endp
delay proc
        push si
        push di
        mov si,0fffh
l2:
        mov di,0ffffh
l1:
        dec di
        jnz l1
        dec si
        jnz l1
        pop di
        pop si
        ret
delay endp

  code ends
  end start
