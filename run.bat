del app
del 1607005.tab.h
del 1607005.tab.c
del lex.yy.c
bison -d 1607005.y
flex 1607005.l
gcc 1607005.tab.c lex.yy.c -o app
app

cmd /k