;从键盘输入4位十六进制数，转换成十进制数显示出来 P185
extrn make1:far
public x
include 8-2.mac
data segment
x dw 0
mess1 db 0dh,0ah,'inputHEX=$'
mess2 db 0dh,0ah,'out dec=$'
dectab db '0123456789'
data ends
stack segment para stack 'stack'
  dw 100h dup(0)
  top dw ?
stack ends
code segment para'code'
assume cs:code,ds:data,ss:stack
start:
mov ax,data
mov ds,ax
mov ax,stack
mov ss,ax
mov sp,offset top

make0 proc far
mov x,0
display mess1
mov bx,0
call make1
call make2
jmp make0
make0 endp

make2 proc
display mess2
mov ax,x
mov dx,0
divis 10000
divis 1000
divis 100
divis 10
divis 1
ret
make2 endp

code ends
end start