assume ds:data, cs:code
data segment
        line db 0ah, 0dh, "$"
        num_prompt db "Enter number of elements:",0ah,0dh,"$"
        ele_prompt db "Enter the elements(max 255):"
        x db 30 dup(?)
        n dw $-x-1
        y db 30 dup(?)
data ends

code segment
digit_2 proc; uses al as register with num to print
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
        lea dx,q
        mov ah,9
        int 21h
single: mov ah,01
        int 21h
        mov bh,00
        mov bl,al
        mov ch,00
        mov cl,bl
        sub cl,'0'
        mov ah,01
        int 21h; see what is pressed next
        mov dl,al
        cmp dl,0dh;
        je startinput ;end of 1st digit stored in cl
        mov dh, 00
        push dx
        mov bh,00
        mov bl,cl
        mov ax,10
        mul bx
        mov bx,ax
        pop dx
        sub dl,'0'
        ;at this point bx,dx is like 1,9 for 19 as input
        add dx,bx
        mov cx,dx;
        mov bx,0
startinput: lea dx,line
        mov ah,9
        int 21h
        lea si,x
        mov bx,0
input:  mov ah,01
        int 21h
        mov dl,al
        inc bx
        mov [si],al
        inc si
        loop input; get input 7 times
out1:   mov dl, 0ah
        mov ah,2
        int 21h
        mov dl, 0dh
        mov ah,2
        int 21h
        mov ah,00
        mov al, '$'
        mov [si],al
        dec si
        lea di,y
        mov cx,bx
next:   mov al,[si]
        mov [di],al
        dec si
        inc di
        loop next
        mov al,'$'
        mov [di],al
        lea dx,y
        mov ah,9
        int 21h

        mov ah,4ch
        int 21h
code ends
end start
