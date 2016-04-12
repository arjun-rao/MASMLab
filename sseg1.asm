;program to display fire and help alternatively
assume cs:code,ds:data

data segment
pa equ 20a0h
pb equ 20a1h
pc equ 20a2h
cr equ 20a3h
cw equ 80h

fire db 71h,09fh,0f5h,61h
help db 0d1h,61h,0e3h,31h


data ends

code segment


start:
	mov ax,data
	mov ds,ax

        ;init 8255
	mov dx,cr
	mov al,cw
	out dx,al
  repeat:
        ;display 4 chars of fire
        mov cx,4
        lea si,fire
  next_char:
        mov al,[si] ;send bits one by one using proc
        call send_bits
        inc si
        call delay
        loop next_char
        
        lea si,help
        mov cx,4
   next_char1:
        mov al,[si]
        call send_bits
        inc si
        call delay
        loop next_char1
        

	
        mov ah,6
        mov dl,0ffh
        int 21h
        jz repeat
       
	
	mov ah,4ch
	int 21h

send_bits proc
        push cx
        push si
;al has 8 bits to be sent one at a time
        mov cx,8
   next_bit:
        ;send 1 bit
        mov dx, pb
        out dx,al
        push ax

        ;send clock pulse
        mov al,00
        mov dx,pc ;for sending clock pulse
        out dx,al

        mov al,0ffh
        out dx,al

        pop ax
        shr al,1
        loop next_bit
        pop si
        pop cx
        ret
send_bits endp


delay proc

         mov si,5fffh
      l2: mov di,0ffffh
      l1: dec di
         jnz l1
         dec si
         jnz l2
         ret
delay endp
code ends
end start
	
