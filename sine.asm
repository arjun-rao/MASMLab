assume cs:code,ds:data

data segment
pa equ 20a0h
pb equ 20a1h
pc equ 20a2h
cr equ 20a3h
cw equ 80h
sine db 0d,11d,22d,33d,43d,54d,63d,72d,81d,90d,97d,104d,109d,115d,119d,125d,126d,127d,126d,122d,119d,115d,109d,104d,97d,90d,81d,72d,63d,54d,43d,33d,22d,11d,0d
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
	mov al,cw
	out dx,al

repeat:	mov dx,pa
	mov cx,35d
	lea si, sine
positive: mov al,[si]
	add al,128d
	out dx,al
	inc si
	loop positive
	
	mov cx,35d
	lea si, sine
neg:	mov al,128d
	mov ah,[si]
	sub al,ah
	out dx,al
	inc si
	loop neg
	
	jmp repeat
	
	mov ah,4ch
	int 21h
code ends
end start
	
