assume cs:code,ds:data

data segment
  n db 5
  res db ?
data ends

code segment

fact proc
  ;al has n
  cmp al,00
  je fact_1
  push ax
  dec al
  call fact
  pop ax
  mul res
  mov res, al
  ret
fact_1:
  mov res,01
  ret
fact endp

start:
    mov ax,data
    mov ds, ax

    mov al,n
    call fact
    mov dl,res
    mov bl,dl
    mov cl,4
    shr dl,cl
    cmp dl,9
    jle add_30
    add dl,7
add_30:
    add dl,30h;
    mov ah,02
    int 21h
    mov dl,bl
    and dl,0Fh
    cmp dl,9
    jle add_30_2
    add dl,7
add_30_2:
    add dl,30h;
    mov ah,02
    int 21h

    mov ah,4ch
    int 21h
code ends
end start
