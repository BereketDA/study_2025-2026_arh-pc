%include 'in_out.asm'

section .data
    a dd 17   ; Первое число
    b dd 23   ; Второе число
    c dd 45   ; Третье число
    msg db "Наименьшее число: ",0h

section .bss
    min resd 1   ; Переменная для хранения минимального значения (4 байта)

section .text
    global _start
_start:
    ; Загружаем 'a' в регистр eax и предполагаем, что это минимум
    mov eax, [a]
    mov [min], eax   ; min = a

    ; Сравниваем 'a' и 'b'
    mov ebx, [b]
    cmp eax, ebx     ; Сравниваем a и b
    jle check_c      ; Если a <= b, переходим к сравнению с c
    mov [min], ebx   ; Иначе min = b
    mov eax, ebx     ; Обновляем eax для следующего сравнения

check_c:
    ; Сравниваем текущий минимум (в eax) с 'c'
    mov ecx, [c]
    cmp eax, ecx     ; Сравниваем min(a,b) и c
    jle print_result ; Если текущий минимум <= c, переходим к выводу
    mov [min], ecx   ; Иначе min = c

print_result:
    ; Вывод сообщения
    mov eax, msg
    call sprint
    ; Вывод минимального числа
    mov eax, [min]
    call iprintLF

    ; Завершение программы
    call quit
