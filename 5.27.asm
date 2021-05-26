data segment
  x db 23
  y db ?
data ends
code segment
  assume cs:code,ds:data
start:mov ax,data
  mov ds,ax
  mov al,x
  cmp al,0
  je sub2
  jg sub1
  mov cl,2
  sal al,cl
  jmp short sub2
 sub1:add al,3
      sar al,1
 sub2:mov y,al
      mov ah,4ch
      int 21h
code ends
end start