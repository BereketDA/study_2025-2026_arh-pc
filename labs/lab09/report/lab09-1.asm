%include 'in_out.asm'

SECTION .data
    msg: DB 'Введите x: ',0
    result: DB '2x+7=',0

SECTION .bss
    x: RESB 80
    res: RESB 80

SECTION .text
GLOBAL _start
_start:

; ---
; Основная программа
; ---
    mov eax, msg
    call sprint

    mov eax, x      ; Адрес буфера для sread
    mov ebx, 80     ; Максимальная длина для sread
    call sread

    mov eax, x      ; Адрес строки для atoi
    call atoi

    call _calcul    ; Вызов подпрограммы _calcul

    mov eax, result
    call sprint
    mov eax, [res]
    call iprintLF

    call quit

; ---
; Подпрограмма вычисления
; выражения "2x+7"
; ---
_calcul:
    mov ebx, 2
    mul ebx
    add eax, 7
    mov [res], eax
    ret    ; выход из подпрограммы
