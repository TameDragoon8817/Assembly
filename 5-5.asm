data segment
  mess1 db 0ah,0dh,'input:$'
  mess2 db 0ah,0dh,'output:$'
  x db ?,?,?
data ends
code segment
  assume cs:code,ds:data
start:
  mov ax,data
  mov ds,ax
let0:mov dx,offset mess1
  mov ah,9
  int 21h
  mov ah,1
  int 21h
  cmp al,27
  jz out1
  cmp al,'0'
  jb let0
  cmp al,'9'
  ja let0
  and al,0fh
  mov ah,0
  mov bl,al
  mul bl
  mul bl
  mov bl,10
  div bl
  add ah,30h
  mov x,ah
  cmp al,10
  jb let2
  mov ah,0
  div bl
  add ah,30h
  mov x+1,ah
  add al,30h
  mov x+2,al
  jmp let3
let2:add al,30h
  mov x+1,al
let3:mov ax,0
  mov dx,offset mess2
  mov ah,9
  int 21h
  mov dl,x+2
  mov ah,2
  int 21h
  mov dl,x+1
  int 21h
  mov dl,x
  int 21h
  mov word ptr x,0
  mov word ptr x+2,0
  jmp let0
out1:mov ah,4ch
  int 21h
code ends
end start