data segment
  infor0 db,0ah,0dh,'sort=$'
  infor1 db,0ah,0dh,'input name:$'
  infor2 db,0ah,0dh,'input score:$'
  n equ 8
  m equ 4
  p equ 3
  q equ 3
  buff1 db n,?,n+1 dup('$')
  buff2 db m,?,m+1 dup('$')
  sname db p dup(n+1 dup('$'))
  score1 dw p dup(m+1 dup('$'))
  score2 dw p dup(m+1 dup(0))
  mingci db p dup(0)
  x dw ?
  sign1 dw 0
  sign2 dw 0
  cont db '1'
data ends

code segment
  assume cs:code,ds:data,es:data
main proc far
start:
  mov ax,data
  mov ds,ax
  mov es,ax
  mov bx,0
  mov cx,0
  call input
  call sort
  call print
  mov ah,4ch
  int 21h
main endp

input proc
  inc bx
  cmp bx,p
  ja exit
  lea dx,infor1
  mov ah,9
  int 21h
  lea dx,buff1
  mov ah,10
  int 21h
  mov al,buff1+1
  add al,2
  mov ah,0
  mov si,ax
  mov buff1[si],'$'
  lea dx,infor2
  mov ah,9
  int 21h
  lea dx,buff2
  mov ah,10
  int 21h
  mov al,buff2+1
  add al,2
  mov ah,0
  mov si,ax
  mov buff2[si],'$'
  mov mingci[bx-1],bl
  cmp bx,1
  jz let1
  add sign1,n+1
  add sign2,q
let1:
  call copy
  jmp input
exit:ret
input endp

copy proc
  mov cx,n+1
  lea si,buff1+2
  lea di,sname
  add di,sign1
  cld
  rep movsb
  mov cx,n
  mov ax,'$'
  lea di,buff1+2
  rep stosb
  mov cx,m+1
  lea si,buff2+
  lea di,score1
  lea di,sign2
  cld
  rep movsb
  lea si,buff2+2
  mov di,sign2
  call change
  ret
copy endp

change proc