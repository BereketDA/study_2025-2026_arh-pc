%include 'in_out.asm'

section .data
    msg_x db "Введите x: ", 0h
    msg_a db "Введите a: ", 0h
    msg_res db "Результат f(x): ", 0h

section .bss
    x resb 10
    a resb 10
    result resd 1   ; для хранения целочисленного результата

section .text
    global _start
_start:
    ; Ввод x
    mov eax, msg_x
    call sprint
    mov eax, x
    mov ebx, 10
    call sread
    mov eax, x
    call atoi
    mov [x], eax    ; сохраняем число x

    ; Ввод a
    mov eax, msg_a
    call sprint
    mov eax, a
    mov ebx, 10
    call sread
    mov eax, a
    call atoi
    mov [a], eax    ; сохраняем число a

    ; Загружаем значения для сравнения
    mov ebx, [x]
    mov ecx, [a]

    ; Сравниваем x и a
    cmp ebx, ecx
    jge x_ge_a      ; если x >= a, переходим к ветке x_ge_a

    ; Ветка x < a: вычисляем 2a - x
    mov eax, ecx    ; eax = a
    add eax, eax    ; eax = 2a
    sub eax, ebx    ; eax = 2a - x
    jmp store_result

x_ge_a:
    ; Ветка x >= a: результат = 8
    mov eax, 8

store_result:
    mov [result], eax

    ; Вывод результата
    mov eax, msg_res
    call sprint
    mov eax, [result]
    call iprintLF

    ; Завершение программы
    call quit
