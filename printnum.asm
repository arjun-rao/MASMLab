assume ds:data, cs:code

data segment
        nums db 12h,25h,0f0h,0abH,1ch
data ends


code segment
digit_2 proc
        push cx
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
        mov dl, ' '
        mov ah,2
        int 21h
        pop cx
        ret
digit_2 endp

start:
        mov ax,data
        mov ds,ax
        mov cx,5
        lea si,nums
   nxt: mov al,[si]
        call digit_2
        inc si
        loop nxt

        mov ah,4ch
        int 21h


code ends
end start
