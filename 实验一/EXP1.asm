displ macro opr
mov ah,2
mov dl,opr
int 21h
endm

clearsc macro
mov ah,06h
mov al,0
mov bh,0F0h
mov ch,0
mov cl,0
mov dh,23
mov dl,79
int 10h
mov dx,0
mov ah,2
int 10h
endm

clearsw macro row1,rank1,row2,rank2,color
mov ah,06h
mov al,0
mov ch,row1
mov cl,rank1
mov dh,row2
mov dl,rank2
mov bh,color
int 10h
endm

windows macro row1,rank1,row2,rank2,color
mov ah,6
mov al,1
mov ch,row1
mov cl,rank1
mov dh,row2
mov dl,rank2
mov bh,color
int 10h
endm

cursor macro row,rank
mov ah,2
mov dh,row
mov dl,rank
mov bh,0
int 10h
endm

enter macro
mov ah,2
mov dl,0dh
int 21h
mov dl,0ah
int 21h
endm

store_ss macro
push ax
push bx
push cx
push dx
endm

restore_ss macro
pop dx
pop cx
pop bx
pop ax
endm

.model small
.data
time1 db ?
time2 db ?
n db 4
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
mess0 db 0ah,0dh,'1.read CMOS clock'
      db 0ah,0dh,'2.read data and time'
      db 0ah,0dh,'3.modify data and time'
      db 0ah,0dh,'select:$'
fix1 db 0ah,0dh,'input year'
fix2 db 0ah,0dh,'input month'
fix3 db 0ah,0dh,'input day'
fix4 db 0ah,0dh,'input week'
fix5 db 0ah,0dh,'input hour'
fix6 db 0ah,0dh,'input minute'
fix7 db 0ah,0dh,'input second'
fix8 db 0ah,0dh,'input percent second'

.code
start:
mov ax,@data
mov ds,ax
let0:
mov dx,offset mess0
mov ah,9
int 21h
mov ah,1
int 21h
cmp al,'1'
jz prog1
cmp al,'2'
jz prog2
cmp al,'3'
jz prog3
jmp prog4

prog1:
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
jmp let0

prog2:
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
jmp let0

prog3:


prog4:
mov ah,4ch
int 21h

code ends
end start