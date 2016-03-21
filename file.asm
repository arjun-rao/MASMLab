assume cs:code,ds:data

data segment
    fname db "test.txt"
    n db 100
    buf db 100 dup(?)
data ends


code segment
start:
  mov ax,data
  mov ds,ax

  mov ah,3dh
  lea dx,fname
  mov al, 00
  int 21h
  jc failed

  mov bx,ax
  mov ah,3fh
  lea dx,buf
  mov cx,100d
  int 21h

  mov ah,3eh
  int 21h

  lea si,buf
  mov cx,100d
next:
  mov ah,02
  mov dl,[si]
  int 21h
  inc si
  loop next;

failed:
  mov ah,4ch
  int 21h

code ends
end start
