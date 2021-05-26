;串扫描。在字数组VALUE中查找-1，找到后将其位置保存在ADDR单元
extra segment
  value dw 1,2,0,3,5,-1,10
  addrr dw ?
extra ends

code segment
  assume cs:code,es:extra
start:
  mov ax,extra
  mov es,ax
  mov ax,-1
  lea di,value
  cld
  mov cx,7
  repnz scasw
  sub di,2
  mov addrr,di
  mov ah,4ch
  int 21h
code ends
end start