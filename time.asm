assume cs:code
code segment
start:
     mov ah,2ch		;function 2C under INT 21h returns time in ch(hrs), cl(mins)
     int 21h		; in hex ( seconds and milliseconds omitted)

     mov al,ch
     call hex_bcd	; first convert the hrs into 24 hrs formatted bcd
     call disp		; then, display it
     mov dl,':'
     mov ah,2
     int 21h		; to display “ : “ in between HH and MM
     mov al,cl		; same thing with minutes
     call hex_bcd
     call disp

     mov ah,4ch
     int 21h

disp proc		; procedure to display 2 bcd digits
     push cx
     mov ah,00h
     mov cx,4
     shl ax,cl
     shr al,cl
     add ax,3030h
     push ax
     mov dl,ah
     mov ah,2
     int 21h
     pop ax
     mov ah,2
     mov dl,al
     int 21h
     pop cx
     ret
disp endp

hex_bcd proc		; procedure to convert hex to bcd
     push cx
     mov cl,al
     mov ch,0
     mov al,0
next:
     add al,1
     daa
     loop next
     pop cx
     ret
hex_bcd endp
code ends
end start
