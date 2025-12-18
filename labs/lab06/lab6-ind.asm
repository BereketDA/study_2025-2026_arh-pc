; ---
; Программа вычисления функции f(x) = (9x - 8)/8
; Вариант 5
; ---

%include 'in_out.asm'

SECTION .data
msg1: DB 'Выражение: f(x) = (9x - 8)/8',0
msg2: DB 'Введите значение x: ',0
msg3: DB 'Результат: ',0

SECTION .bss
x: RESB 80

SECTION .text
GLOBAL _start
_start:

mov eax, msg1
call sprintLF

mov eax, msg2
call sprint

mov ecx, x
mov edx, 80
call sread

mov eax, x
call atoi        ; преобразуем введённую строку в число (x в eax)

; Вычисление (9x - 8)/8
mov ebx, 9
mul ebx          ; eax = 9*x
sub eax, 8       ; eax = 9x - 8

xor edx, edx     ; обнуляем edx для деления
mov ebx, 8
div ebx          ; eax = (9x - 8) / 8, edx = остаток

mov edi, eax     ; сохраняем результат в edi

mov eax, msg3
call sprint
mov eax, edi
call iprintLF

call quit
