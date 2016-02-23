assume ds:data, cs:code

data segment
        
data ends


code segment
digit_2 proc
        push cx
        push bx
        mov bl,al
        mov cl,4
        shr al,cl
        cmp al,9
        jle add_30
        add al,7
  add_30: add al,30h
        mov dl,al
        mov ah,2
        int 21h
        mov dl, bl
        and dl,0fH
        cmp dl,09
        jle add_30_2
        add dl,7
add_30_2: add dl,30h
        mov ah,2
        int 21h
        mov dl, ':'
        mov ah,2
        int 21h
        pop bx
        pop cx
        ret
digit_2 endp

start:
        mov ax,data
        mov ds,ax
        mov cx,0ffh
        mov bl,0
   nxt: mov al,bl
        call digit_2
        mov dl,bl
        mov ah,02
        int 21h
        mov dl,' '
        int 21h
        inc bl
        loop nxt

        mov ah,4ch
        int 21h


code ends
end start
