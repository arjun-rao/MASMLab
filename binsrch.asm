assume cs:code,ds:data

data segment
  x  db 10h,20h,30h,40h,50h,60h,70h
  n db $-x;
  key db 20h
  pass db "Element found at position:$"
  fail db "Element not found$"
  line db 0ah,0dh,"$"
data ends


code segment
digit_2 PROC
  push bx
  push cx
  push dx
  mov bl,al
  mov cl,4
  shr al,cl
  mov dl,al
  cmp dl, 9
  jle add_30
  add dl,7
add_30:
  add dl,30h
  mov ah,02
  int 21h
  AND bl,0fh
  mov dl,bl
  cmp dl, 9
  jle add_30_2
  add dl,7
add_30_2:
  add dl,30h
  mov ah,02
  int 21h
  pop dx
  pop cx
  pop bx
  ret
digit_2 ENDP
start:
    mov ax,data
    mov ds, ax

    ;cl=low,ch=high;dh=mid
    mov cl,0
    mov ch,n
    lea bx, x;for use with xlat
next: cmp cl,ch
    ja after_loop;
    mov dh, cl
    add dh,ch; dh = cl+ch
    shr dh,1; dh = mid
    mov al,dh
    xlat
    cmp al,key
    je found;
    jb change_low; a[mid]<key
    mov ch,dh; change_high
    dec ch
    jmp next; repeat
change_low:
    mov cl,dh
    inc cl
    jmp next; repeat
after_loop:
    lea dx,fail
    mov ah,9
    int 21h
    jmp eprog
found:
    mov ch,dh
    lea dx,pass
    mov ah,9
    int 21h
    pop dx
    mov al,ch
    call digit_2
eprog:
    mov ah,4ch
    int 21h
code ends
end start
