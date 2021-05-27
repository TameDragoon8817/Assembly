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