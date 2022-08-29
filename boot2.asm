;Imprime algun mensaje en pantalla
%macro imprimir 1
    mov si, %1            
    mov ah, 0x0E          
    %%loop	lodsb                  
        or al, al               
        jz %%end                 
        int 0x10              
        jmp %%loop               
    %%end:
%endmacro

;Guarda el caracter que ingreso el user, funciona junto a "entrada"
%macro caracter_de_entrada 1
    mov ah, 0x0
	int 0x16
	mov [%1] , al
%endmacro

;Compara los caracteres de entrada con los posibles correctos
%macro comparador 1
    mov cl, 'f'
    cmp [bx], cl
    JE correcto
    mov cl, 'u'
    cmp [bx], cl
    JE correcto
    mov cl, 'p'
    cmp [bx], cl
    JE correcto
    mov cl, 'x'
    cmp [bx], cl
    JE correcto
%endmacro

;Recibe el input del usuario y lo guarda en una variable
%macro entrada 1
    %%read_string: 
        mov bx, %1
    %%start_process:
        cmp cx,10
        jz %%end_read
        caracter_de_entrada bx 
        comparador bx
        imprimir bx
        inc bx
        inc cx
    %%end_read:

%endmacro

;Salto de linea basico
%macro salto_linea 0
    mov al, 0x0A
    int 10h
    mov al, 0x0D
    int 10h
%endmacro

;Muchos saltos de linea
%macro limpiar_pantalla 0
    mov cx, 40
    %%loop_clear:
        cmp cx, 20
        jz %%end_loop
        dec cx
        salto_linea
        jmp %%loop_clear
    %%end_loop:
        salto_linea
%endmacro