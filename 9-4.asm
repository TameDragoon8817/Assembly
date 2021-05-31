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

displ macro opr
mov ah,2
mov dl,opr
int 21h
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

;在屏幕右上角显示系统当前的日期和时间 P219
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