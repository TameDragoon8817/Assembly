;在屏幕右上角开窗口显示两次读取的时钟计数器当前值和计数差值 P222
include 9-4.mac
.model small
.data
letter1 db 'count1= ','$'
letter2 db 'count2= ','$'
letter3 db 'total= ','$'
higher1 dw ?
lower1 dw ?
higher2 dw ?
lower2 dw ?
total dw ?

.code
start:
mov ax,@data
mov ds,ax
clearsc
clearsw 2,50,6,78,6fh
cursor 3,51
mov ah,9
mov dx,offset letter1
int 21h

mov ah,00h
int 1ah
mov higher1,cx
mov lower1,dx
reptt:
mov ah,00h
int 1ah
mov higher2,cx
mov lower2,dx
mov ax,lower2
sub ax,lower1
cmp ax,36
jl reptt
mov total,ax

mov bx,higher1
call disp_2_10
displ '/'
mov bx,lower1
call disp_2_10

cursor 4,51
mov ah,9
mov dx,offset letter2
int 21h
mov bx,higher2
call disp_2_10
displ '/'
mov bx,lower2
call disp_2_10

cursor 5,51
mov ah,9
mov dx,offset letter3
int 21h
mov bx,total
call disp_2_10
out1:
mov ah,4ch
int 21h

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