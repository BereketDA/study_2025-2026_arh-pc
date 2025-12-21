;---------------   slen  -------------------
; Функция вычисления длины сообщения
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


;---------------  sprint  -------------------
; Функция печати сообщения
; входные данные: mov eax,<message>
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
    
    mov     edx, eax
    pop     eax
    
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h

    pop     ebx
    pop     ecx
    pop     edx
    ret


;----------------  sprintLF  ----------------
; Функция печати сообщения с переводом строки
; входные данные: mov eax,<message>
sprintLF:
    call    sprint

    push    eax
    mov     eax, 0AH
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret

;---------------  sread  ----------------------
; Функция считывания сообщения
; входные данные: mov eax,<buffer>, mov ebx,<max length>
; Возвращает: буфер с нуль-терминированной строкой (без символа новой строки)
sread:
    push    ecx
    push    edx
    push    ebx
    push    eax

    mov     ecx, eax    ; адрес буфера -> ecx
    mov     edx, ebx    ; длина -> edx
    mov     ebx, 0      ; файловый дескриптор (stdin)
    mov     eax, 3      ; номер системного вызова (sys_read)
    int     80h

    ; Нуль-терминируем строку (заменяем символ новой строки на 0)
    mov     byte [ecx + eax - 1], 0

    pop     eax
    pop     ebx
    pop     edx
    pop     ecx
    ret

;------------- iprint  ---------------------
; Функция вывода на экран чисел в формате ASCII
; входные данные: mov eax,<int>
iprint:
    push    eax             
    push    ecx             
    push    edx             
    push    esi             
    mov     ecx, 0          
    
divideLoop:
    inc     ecx             
    mov     edx, 0          
    mov     esi, 10  
    idiv    esi    
    add     edx, 48  
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


;--------------- iprintLF   --------------------
; Функция вывода на экран чисел в формате ASCII
; входные данные: mov eax,<int>
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

;----------------- atoi  ---------------------
; Функция преобразования ascii-код символа в целое число
; входные данные: mov eax,<string> (нуль-терминированная)
; возвращает: eax = число
atoi:
    push    ebx             
    push    ecx             
    push    edx             
    push    esi             
    mov     esi, eax        
    mov     eax, 0          
    mov     ecx, 0          
 
.multiplyLoop:
    xor     ebx, ebx        
    mov     bl, [esi+ecx]
    cmp     bl, 48 
    jl      .finished 
    cmp     bl, 57  
    jg      .finished 
 
    sub     bl, 48 
    imul    eax, 10
    add     eax, ebx
    inc     ecx   
    jmp     .multiplyLoop  
 
.finished:
    pop     esi   
    pop     edx    
    pop     ecx  
    pop     ebx 
    ret


;------------- quit   ---------------------
; Функция завершения программы
quit:
    mov     ebx, 0      
    mov     eax, 1      
    int     80h
    ret

;---------------  strlen  -------------------
; Функция вычисления длины сообщения (alias для slen)
strlen:
    jmp slen
