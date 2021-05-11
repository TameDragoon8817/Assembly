.model small
.stack 100h
.code
start:
   mov ah,1
   int 21h
   mov bl,al
   int 21h
   add al,bl
   mov ah,0
   aaa
   add ax,3030h
   mov si,ax
   mov ax,0b800h
   mov es,ax
   mov ah,3
   mov bh,0
   int 10h
   mov al,160
   mul dh
   mov dh,0
   shl dl,1
   add ax,dx
   mov bx,ax
   mov ax,si
   mov byte ptr es:[bx+0],3dh
   mov es:[bx+2],ah
   mov byte ptr es:[bx+3],1eh
   mov es:[bx+4],al
   mov byte ptr es:[bx+5],1dh
   mov ah,4ch
   int 21h
end start