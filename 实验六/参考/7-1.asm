;多次输入一个65535以内的十进制数并且以十六进制显示出来 P148
data segment
  x dw 0
  mess1 db 0dh,0ah,'input dec=$'
  mess2 db 0dh,0ah,'outHEX=$'
  hex db '0123456789ABCDEF'
data ends
code segment
  assume cs:code,ds:data
start:
  mov ax,data
  mov ds,ax
let0:
  mov x,0
  mov dx,offset mess1
  mov ah,9
  int 21h
  call let1
  call let2
  jmp let0
let1:
  mov ah,1
  int 21h
  cmp al,27
  jz out1
  sub al,30h
  jl exit
  cmp al,9
  jg exit
  mov ah,0
  xchg ax,x
  mov cx,10
  mul cx
  add x,ax
  jmp let1
exit:ret
let2:
  mov dx,offset mess2
  mov ah,9
  int 21h
  mov bx,x
  mov ch,4
  mov cl,4
  rept1:
    rol bx,cl
    mov ax,bx
    and ax,000fh
    mov si,ax
    mov dl,hex[si]
    mov ah,2
    int 21h
    dec ch
    jnz rept1
    ret
out1:
  mov ah,4ch
  int 21h
code ends
end start

;回车是0dh 换行是0Ah