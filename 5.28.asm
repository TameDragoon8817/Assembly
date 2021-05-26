data segment
  x db 3
  y db 5
  z db ?
data ends
code segment
  assume cs:code,ds:data
start:
  mov ax,data