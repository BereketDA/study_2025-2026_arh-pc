%include 'in_out.asm'

SECTION .data
    msg: DB 'Введите x: ',0
    result: DB 'f(g(x))=2*(3x-1)+7=',0

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
; Подпрограмма вычисления f(g(x)) = 2*(3x-1)+7
; Вход: eax = x (число)
; Выход: результат в [res]
; ---
_calcul:
    ; Сохраняем x (в eax) для передачи в _subcalcul
    ; Или оно уже в eax? Да, atoi помещает число в eax.
    ; Вызываем _subcalcul для вычисления g(x) = 3x - 1
    call _subcalcul
    ; Теперь в eax результат g(x)
    ; Вычисляем f(g(x)) = 2 * eax + 7
    mov ebx, 2
    mul ebx         ; eax = 2 * g(x)
    add eax, 7      ; eax = 2*g(x) + 7
    mov [res], eax
    ret

; ---
; Подпрограмма вычисления g(x) = 3x - 1
; Вход: eax = x (число)
; Выход: eax = 3x - 1
; ---
_subcalcul:
    mov ebx, 3
    mul ebx         ; eax = 3 * x
    sub eax, 1      ; eax = 3x - 1
    ret
