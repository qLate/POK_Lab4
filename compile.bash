rm hello.o hello.exe

INCLUDE=Examples/x86/include ./fasmg.exe Examples/hello_win64_con_o.asm hello.o
gcc hello.o -o hello.exe
./hello.exe