;---
; Программа для самостоятельной работы (ЛР10)
; Алгоритм:
; 1. Вывод приглашения "Как Вас зовут?"
; 2. Ввод с клавиатуры фамилии и имени
; 3. Создание файла name.txt
; 4. Запись в файл сообщения "Меня зовут"
; 5. Дописать в файл строку, введенную с клавиатуры
; 6. Закрыть файл
;---
%include 'in_out.asm'

SECTION .data
prompt db 'Как Вас зовут? ', 0h
msg    db 'Меня зовут ', 0h
fname  db 'name.txt', 0h

SECTION .bss
input resb 255   ; буфер для ввода имени

SECTION .text
global _start
_start:

; --- Печать приглашения
mov eax, prompt
call sprint

; --- Чтение строки (имени) с клавиатуры
mov ecx, input
mov edx, 255
call sread

; --- Создание файла name.txt
mov ecx, 0777o  ; Права доступа rwxrwxrwx
mov ebx, fname  ; Имя файла
mov eax, 8      ; sys_creat
int 0x80
mov esi, eax    ; Сохраняем дескриптор файла в ESI

; --- Запись в файл строки "Меня зовут "
mov eax, msg
call slen          ; Вычисляем длину строки msg, результат в EAX
mov edx, eax       ; Длина для записи
mov ecx, msg       ; Адрес строки
mov ebx, esi       ; Дескриптор файла
mov eax, 4         ; sys_write
int 0x80

; --- Запись в файл введенного имени (input)
mov eax, input
call slen          ; Длина строки input
mov edx, eax       ; Длина для записи
mov ecx, input     ; Адрес строки
mov ebx, esi       ; Дескриптор файла
mov eax, 4         ; sys_write
int 0x80

; --- Закрытие файла
mov ebx, esi       ; Дескриптор файла
mov eax, 6         ; sys_close
int 0x80

; --- Завершение программы
call quit
