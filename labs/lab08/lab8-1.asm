; ---
; Программа вывода значений регистра 'ecx' с использованием стека
; ---

%include 'in_out.asm'

SECTION .data
msg1 db 'Введите N: ',0h

SECTION .bss
buf:    resb 10   ; буфер для ввода строки
N:      resd 1    ; здесь хранится число N

SECTION .text
    global _start
_start:

; ---   Вывод сообщения 'Введите N: '
    mov  eax, msg1
    call sprint

; ---   Ввод строки в буфер 'buf'
    mov  eax, buf
    mov  ebx, 10
    call sread

; ---   Преобразование строки в число и сохранение в 'N'
    mov  eax, buf
    call atoi
    mov  [N], eax

; ---   Организация цикла с сохранением счетчика в стеке
    mov  ecx, [N]    ; Счетчик цикла, `ecx=N`
label:
    push ecx         ; добавление значения ecx в стек
    sub  ecx, 1      ; изменение значения ecx
    mov  eax, ecx    ; Выводим текущее значение ecx
    call iprintLF
    pop  ecx         ; извлечение значения ecx из стека
    loop label       ; `ecx=ecx-1` и если `ecx` не '0', переход к `label`

    call quit
