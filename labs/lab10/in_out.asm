;----------------------------------------------------------
; Файл `in_out.asm` для NASM под 32-bit Linux (системные вызовы int 80h)
;----------------------------------------------------------
global  sprint, sprintLF, sread, slen, iprint, iprintLF, quit

;----------------------------------------------------------
; Вывод строки в stdout
; eax = адрес строки
;----------------------------------------------------------
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen          ; вычисляем длину строки в eax

    mov     edx, eax      ; длина строки
    pop     eax           ; адрес строки
    mov     ecx, eax      ; адрес строки
    mov     ebx, 1        ; файловый дескриптор stdout
    mov     eax, 4        ; системный вызов sys_write
    int     80h

    pop     ebx
    pop     ecx
    pop     edx
    ret

;----------------------------------------------------------
; Вывод строки с переводом строки (LF)
; eax = адрес строки
;----------------------------------------------------------
sprintLF:
    call    sprint
    push    eax
    mov     eax, 0Ah      ; символ перевода строки
    push    eax
    mov     eax, esp      ; адрес символа
    call    sprint
    pop     eax
    pop     eax
    ret

;----------------------------------------------------------
; Ввод строки из stdin
; ecx = адрес буфера
; edx = размер буфера
;----------------------------------------------------------
sread:
    push    eax
    push    ebx
    mov     ebx, 0        ; файловый дескриптор stdin
    mov     eax, 3        ; системный вызов sys_read
    int     80h
    pop     ebx
    pop     eax
    ; Убираем символ новой строки (заменяем на 0)
    push    ecx
    push    ebx
    mov     ebx, ecx      ; адрес буфера
    add     ebx, eax      ; адрес последнего прочитанного символа
    sub     ebx, 1
    mov     byte [ebx], 0 ; заменяем '\n' на '\0'
    pop     ebx
    pop     ecx
    ret

;----------------------------------------------------------
; Вычисление длины строки
; eax = адрес строки
; возвращает eax = длина строки
;----------------------------------------------------------
slen:
    push    ebx
    mov     ebx, eax
nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar
finished:
    sub     eax, ebx
    pop     ebx
    ret

;----------------------------------------------------------
; Вывод целого числа (со знаком)
; eax = целое число
;----------------------------------------------------------
iprint:
    push    eax
    push    ecx
    push    edx
    push    esi
    mov     ecx, 0        ; счетчик цифр
divideLoop:
    inc     ecx
    mov     edx, 0
    mov     esi, 10
    idiv    esi           ; eax = eax/10, edx = остаток
    add     edx, 48       ; преобразуем остаток в ASCII
    push    edx
    cmp     eax, 0
    jnz     divideLoop
printLoop:
    dec     ecx
    mov     eax, esp
    call    sprint
    pop     eax
    cmp     ecx, 0
    jnz     printLoop
    pop     esi
    pop     edx
    pop     ecx
    pop     eax
    ret

;----------------------------------------------------------
; Вывод целого числа с переводом строки
; eax = целое число
;----------------------------------------------------------
iprintLF:
    call    iprint
    push    eax
    mov     eax, 0Ah
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret

;----------------------------------------------------------
; Завершение программы
;----------------------------------------------------------
quit:
    mov     ebx, 0        ; код возврата 0
    mov     eax, 1        ; системный вызов sys_exit
    int     80h
