%include 'in_out.asm'
section .data
msg1 db 'Введите B: ',0h
msg2 db "Наибольшее число: ",0h
A dd '20'
C dd '50'
section .bss
max resb 10
B resb 10

section    .text
    global _start
_start:
; ---  Вывод сообщения 'Введите В: '
    mov  eax,msg1
    call sprint
; ---  Ввод 'В'
    mov eax,B
    mov  ebx,10
    call sread
; ---  Преобразование 'В' из символа в число
    mov  eax,B
    call atoi    ; Вызов подпрограммы перевода символа в число
    mov  [B],eax    ; запись преобразованного числа в 'В'
; ---  Записываем 'А' в переменную 'max'
    mov  ecx,[A]   ; 'ecx = A'
    mov  [max],ecx  ; 'max = A'
; ---  Сравниваем 'А' и 'С' (как символы)
    cmp  ecx,[C]   ; Сравниваем 'А' и 'С'
    jg  check_B   ; если 'А>С', то переход на метку 'check_B',
    mov  ecx,[C]   ; иначе 'ecx = C'
    mov  [max],ecx  ; 'max = C'
; ---  Преобразование 'max(A,C)' из символа в число
check_B:
    mov  eax,max
    call atoi    ; Вызов подпрограммы перевода символа в число
    mov  [max],eax  ; запись преобразованного числа в 'max'
; ---  Сравниваем 'max(A,C)' и 'В' (как числа)
    mov  ecx,[max]
    cmp  ecx,[B]   ; Сравниваем 'max(A,C)' и 'В'
    jg  fin    ; если 'max(A,C)>B', то переход на 'fin',
    mov  ecx,[B]   ; иначе 'ecx = B'
    mov  [max],ecx
; ---  Вывод результата
fin:
    mov  eax, msg2
    call sprint    ; Вывод сообщения 'Наибольшее число: '
    mov  eax,[max]
    call iprintLF  ; Вывод 'max(A,B,C)"
    call quit    ; Выход
