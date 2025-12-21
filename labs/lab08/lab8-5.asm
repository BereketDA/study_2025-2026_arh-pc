; ---
; Программа вычисления суммы f(x) = 2x + 15 для аргументов командной строки
; ---

%include 'in_out.asm'

SECTION .data
msg_func db "Функция: f(x)=2x+15",0h
msg_res  db "Результат: ",0

SECTION .text
global _start

_start:
    pop ecx            ; количество аргументов
    pop edx            ; имя программы
    sub ecx, 1         ; ecx = количество чисел x
    mov esi, 0         ; esi = накопитель суммы

next:
    cmp ecx, 0
    jz _end
    pop eax            ; аргумент (x как строка)
    call atoi          ; преобразуем в число в eax
    ; Вычисляем f(x) = 2x + 15
    mov ebx, eax       ; сохраняем x в ebx
    add eax, eax       ; eax = 2x
    add eax, 15        ; eax = 2x + 15
    add esi, eax       ; добавляем к сумме
    loop next

_end:
    ; Вывод сообщения о функции
    mov eax, msg_func
    call sprintLF
    ; Вывод результата
    mov eax, msg_res
    call sprint
    mov eax, esi
    call iprintLF
    call quit
