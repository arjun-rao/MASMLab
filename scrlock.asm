;NOTE: THIS CODE IS INCOMPLETE.... 

assume cs:code,ds:data

data segment
        str db "Enter password: ","$";
        n db n-str;length of string
        ipass db 100 dup(?)
        spass db "MASM<3ftw"
        ilen dw ?
        allow db 0ah,"Access Granted!","$"
        deny db 0ah,"Access Denied","$"
        locked db "System Locked!$";
        lock_len db lock_len-locked;
data ends

code segment
readkb macro
        mov ah,7
        int 21h
        cmp al,0dh
        jz stop;
        mov [si],al
        inc si
        mov dl,'*'
        mov ah,02
        int 21h
endm 
start:
        mov ax,data
        mov ds,ax
        mov es,ax; to use string insructions later
        mov bp,3;
next_try:
        mov ah,0
        mov al,3 ;initialise screen resolution to  80x25
        int 10h
        mov ah,2 ;sets cursor position 
        mov dh,12d;row no
        mov dl,40d;col no
        sub dl,n
        int 10h
        lea dx,str;displays password prompt
        mov ah,9
        int 21h
        ;start reading input
        mov bx,0
 n_char:
        readkb;read one char
        inc bx
        jmp n_char
 stop:
        mov ilen,bx;store pwd len in ilen
        mov cl,n
        mov ch,00
        cmp cx,ilen
        jnz fail
        lea si,ipass
        lea di,spass
        repz cmpsb
        jz success
fail:
        lea dx,deny
        mov ah,9
        int 21h
        dec bp;
        jnz next_try
        
        ;lock system
        
        mov ah,0
        mov al,3 ;initialise screen resolution to  80x25
        int 10h
        mov ah,2 ;sets cursor position 
        mov dh,12d;row no
        mov dl,40d;col no
        sub dl,lock_len
        int 10h
        lea dx,locked;displays lockedmsg
        mov ah,9
        int 21h
        jmp done;
;freeze: jmp freeze;
success:
        lea dx,allow
        mov ah,9
        int 21h
done:        
        mov ah,4ch
        int 21h
code ends
end start
