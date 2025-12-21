%include 'in_out.asm'

SECTION .data
div: DB 'Результат: ',0

SECTION .text
GLOBAL _start
_start:

; --- Вычисление выражения (3+2)*4+5
    mov ebx,3
    mov eax,2
    add ebx,eax      ; ebx = 5
    mov eax, ebx     ; перемещаем сумму в eax для умножения
    mov ecx,4
    mul ecx          ; eax = 5 * 4 = 20
    add eax,5        ; eax = 20 + 5 = 25
    mov edi, eax     ; сохраняем результат в edi

; --- Вывод результата на экран
mov  eax,div
call sprint
mov  eax,edi
call iprintLF

call quit
