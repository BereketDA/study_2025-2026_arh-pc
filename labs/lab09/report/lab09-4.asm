%include 'in_out.asm'

SECTION .data
    msg: DB 'Введите x: ',0
    result: DB 'f(x)=(x+1)*2=',0

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

    mov eax, x
    mov ebx, 80
    call sread

    mov eax, x
    call atoi

    call calc_f    ; Вызов подпрограммы calc_f

    mov eax, result
    call sprint
    mov eax, [res]
    call iprintLF

    call quit

; ---
; Подпрограмма вычисления f(x) = (x + 1) * 2
; Вход:  eax = x (число)
; Выход: результат в [res]
; ---
calc_f:
    inc eax        ; eax = x + 1
    mov ebx, 2
    mul ebx        ; eax = (x + 1) * 2
    mov [res], eax
    ret
