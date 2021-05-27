data segment
  infor0 db 0ah,0dh,'sort=$'
  infor1 db 0ah,0dh,'input name:$'
  infor2 db 0ah,0dh,'input score:$'
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
  lea si,buff2+2
  lea di,score1
  add di,sign2
  cld
  rep movsb
  lea si,buff2+2
  mov di,sign2
  call change
  ret
copy endp

change proc
  mov x,0
  mov cx,[si-1]
  and cx,000fh
rept2:
  mov al,[si]
  cmp al,30h
  jl exit1
  cmp al,39h
  jg exit1
  and ax,000fh
  xchg ax,x
  mov dx,10
  mul dx
  add x,ax
  inc si
  loop rept2
  mov ax,x
  mov score2[di],ax
  mov x,0
  add sign2,2
exit1:ret
change endp

sort proc
  mov cx,p
  dec cx
loop1:
  push cx
  mov bx,0
  mov si,0
loop2:
  mov ax,score2[bx]
  cmp ax,score2[bx+m+1]
  jge next
  xchg ax,score2[bx+m+1]
  mov score2[bx],ax
  mov al,mingci[si]
  xchg al,mingci[si+1]
  mov mingci[si],al
next:
  add bx,m+1
  inc si
  loop loop2
  pop cx
  loop loop1
  ret
sort endp

print proc
  lea dx,infor0
  mov ah,9
  int 21h
  mov cx,p
  mov bx,0
  mov ax,0
  mov di,0
rept3:
  mov dl,0ah
  mov ah,2
  int 21h
  mov dl,0dh
  int 21h
  mov dl,cont
  mov ah,2
  int 21h
  inc cont
  mov dl,0ah
  mov ah,2
  int 21h
  mov dl,0dh
  int 21h
  mov ax,0
  mov al,mingci[di]
  dec al
  mov bl,9
  mul bl
  lea dx,sname
  add dx,ax
  mov ah,9
  int 21h
  mov dl,0ah
  mov ah,2
  int 21h
  mov dl,0dh
  int 21h
  mov ax,0
  mov bx,0
  mov al,mingci[di]
  dec al
  mov bl,5
  mul bl
  lea dx,score1
  add dx,ax
  mov ah,9
  int 21h
  inc di
  loop rept3
  ret
print endp

code ends
end start