;在屏幕的窗口中显示字符串，并照样输入该字符串 P209
include 9-3.mac
.model small
.data
letter db 'Every success in your study.',0ah,0dh,'$'
mess db 29,32 dup(?)
cont db ?

.code
start:
mov ax,@data
mov ds,ax
clearsc
clearsw
reptt:
mov ah,2
mov dh,8
mov dl,30
mov bh,0
int 10h
mov ah,9
mov dx,offset letter
int 21h
mov ah,2
mov dh,15
mov dl,30
mov bh,0
int 10h
mov al,0
mov ah,10
mov dx,offset mess
int 21h
mov ah,6
mov al,1
mov ch,8
mov cl,30
mov dh,15
mov dl,60
mov bh,27h
int 10h
inc cont
cmp cont,3
jne reptt
out1:
mov ah,4ch
int 21h
end start