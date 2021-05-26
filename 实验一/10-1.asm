;利用I/O指令读取CMOS实时时钟值，并显示出来 P232
displ macro opr
mov ah,2
mov dl,opr
int 21h
endm
.model small
.data
time1 db ?
time2 db ?
n db 4
.code
start:
mov ax,@data
mov ds,ax
lll:
mov al,n
out 70h,al
in al,71h
mov ah,al
mov cl,4
shr ah,cl
add ah,30h
and al,0fh
add al,30h
mov time1,ah
mov time2,al
displ time1
displ time2
sub n,2
js exit
displ':'
jmp lll
exit:
mov ah,4ch
int 21h
end start