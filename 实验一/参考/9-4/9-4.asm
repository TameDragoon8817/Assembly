;在屏幕右上角显示系统当前的日期和时间 P219
include 9-4.mac
.model small
.data
letter1 db 'Date and week = ','$'
letter2 db 'Time= ','$'
nears dw ?
month db ?
day db ?
week db ?
hour db ?
minutes db ?
seconds db ?
persec db ?
.code

start:
mov ax,@data
mov ds,ax
clearsc
cursor 2,50
mov ah,9
mov dx,offset letter1
int 21h

mov ah,2ah
int 21h
mov nears,cx
mov month,dh
mov day,dl
mov week,al
;调用2-10显示子程序
mov bx,nears
call disp_2_10
displ '/'
mov bx,0
mov bl,day
call disp_2_10
displ '/'
mov bx,0
mov bl,week
call disp_2_10
enter
cursor 3,50
mov ah,9
mov dx,offset letter2
int 21h

mov ah,2ch
int 21h
mov hour,ch
mov minutes,cl
mov seconds,dh
mov persec,dl
;调用disp_2_10显示子程序
mov bx,0
mov bl,hour
call disp_2_10
displ ':'
mov bx,0
mov bl,minutes
call disp_2_10
displ ':'
mov bx,0
mov bl,seconds
call disp_2_10
displ ':'
mov bx,0
mov bl,persec
call disp_2_10
out1:
mov ah,4ch
int 21h
;子程序，二进制-十进制数显示，对bx值，显示十进制结果
disp_2_10 proc
store_ss
mov ax,bx
mov cx,0
mov bx,10
let1:
mov dx,0
inc cx
idiv bx
push dx
cmp ax,0
jnz let1
let2:
pop ax
add ax,0030h
mov dl,al
mov ah,2
int 21h
loop let2
restore_ss
ret
disp_2_10 endp
end start