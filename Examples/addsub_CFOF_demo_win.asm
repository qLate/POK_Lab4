; Приклад встановлення прапорців при відніманні і додаванні
; Початкова версія взята зі статті
;"Перенос и переполнение - что они представляют
;собой на самом деле?" Чугайнова Н.Г. %
;(\verb http://www.wasm.ru/article.php?article=carry_overflow  )

include 'win32ax.inc'

.code
start:

    ;===>   1.) Переноси в біт знаку та за розрядну сітку відсутні
        mov al, 00111111b
        mov bl, 00000001b

        add al, bl
        ;результат - 0111 1111b
        ;Тому CF=0, OF=0

    ;===>   2.) Відбувається перенос в біт знаку. Виходу за розрядну сітку немає
        mov al, 01000000b  ;
        mov bl, 01000000b  ;
        add al, bl         ;
        ;Результат 1000 0000b
        ;Старший біт дорівнює 1.
        ;Переносу за розрядну сітку не було
        ;CF=0, OF=1
        ;Вважаємо беззнаковими: 64 + 64 = 128 -- правильно
        ;Вважаємо числами зі знаком (+64) + (+64) = -128 -- ви і самі бачите :-)

    ;===>   3.) Відбувається і перенос в біт знаку і перенос за межі розрядної сітки.
        mov al, 11111100b
        mov bl, 00000101b
        add al, bl
        ;Результат: 0000 0001b
        ;252 + 5 = 1 --- неправильно
        ; -4 + 5 = 1 --- правильно
        ;мало б бути CF=1, OF=1
        ;є CF=1, OF=0!

        mov al, 11100000b
        mov bl, 11100000b
        add al, bl
        ;Результат -- 0000 0000b
        ;224 + 224 = 192 --- неправильно
        ;-32 -  32 = -64 --- правильно
        ;мало б бути CF=1, OF=1
        ;є CF=1, OF=0!
    ;===>   4.) ,Відбувається тільки вихід за розрядну сітку

        mov al, 10000000b
        mov bl, 10000000b
        add al, bl
        ;Результат 1100 0000b
        ;128 + 128 = 0 --- неправильно
        ;-128 - 128 = 0 --- неправильно
        ;CF=1, OF=1

    invoke  ExitProcess,0

.data
;define bytes
dummy       db  55h;

.end start
