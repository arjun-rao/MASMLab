assume cs:code,ds:data

data segment
pa equ 20a0h
pb equ 20a1h
pc equ 20a2h
cr equ 20a3h
cw equ 80h
data ends

code segment
delay proc
      mov si,0fffh
  l2: mov di,0ffffh
  l1: dec di
      jnz l1
      dec si
      jnz l2
      ret
delay endp


start:
	mov ax,data
	mov ds,ax
	
	mov dx,cr
        mov al,80h
        out dx,al

        mov cx,50d

        mov al,11h

        mov dx,pa
 nexts: out dx,al
       ; call delay
        rol al,1
        loop nexts

	
	mov ah,4ch
	int 21h
code ends
end start
	
