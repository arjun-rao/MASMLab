assume cs:code,ds:data

data segment
        x db 1,2,3,4,5
        n dw $-x
        y db 11h,22h,33h,44h,55h
data ends

code segment
start:
        mov ax,data
        mov ds,ax
        mov cx,n
        lea si,x
        lea di,y
next:   mov al,[si]
        mov bl,[di]
        mov [si],bl
        mov [di],al
        inc si
        inc di
        loop next

        mov ah,4ch
        int 21h
code ends
end start

