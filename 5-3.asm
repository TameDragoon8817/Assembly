;区分和统计键入的数字、大写字母、小写字母
data segment
  numb db 10 dup(?)
  capi db 10 dup(?)
  lett db 10 dup(?)
data ends

code segment
  assume cs:code,ds:data
start:
  mov ax,data
  mov ds,ax
let0:
  mov ah,1
  int 21h
  cmp al,0dh
  jz exit
  test al,40h
  jz let1
  test al,20h
  jz let2
  cmp al,7ah
  ja exit
  mov lett[bx],al
  inc bx
  jmp let0
let2:
  cmp al,5ah
  ja exit
  mov capi[si],al
  inc si
  jmp let0
let1:
  cmp al,'0'
  jb exit
  cmp al,'9'
  ja exit
  mov numb[di],al
  inc di
  jmp let0
exit:
  mov ah,4ch
  int 21h
code ends
end start