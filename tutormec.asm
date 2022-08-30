BITS 16
%include "tutormec_lib.asm"
start:
    ;Hace todos los cambios de direcciones de los registros
    mov ax, 07C0h
    add ax, 288
    mov ss, ax
    mov sp, 4096
    
    mov ax, 07C0h
    mov ds, ax

    ;Llama al main
    call main    ; main
    jmp $
    welcomeText: db "Bienvenido a TutorMec, presione las teclas!" , 0,
    blockStructure: db "Teclas:  f    p   x   u ", 10, 0x0D,
                    db "---- ---- ---- ---- ----", 10, 0x0D, 
                    db "|  | |  | |  | |  | |  |", 10, 0x0D,
                    db "---- ---- ---- ---- ----", 10, 0x0D,
                    db "'f' (Dedo indice izq) | 'p' (Dedo menique der) |'x' (Dedo anular izq) | 'u' (Dedo corazon der)", 10, 0x0D,
                    db "Tecla presionada: '", 0
    mensaje_exitoso: db "', tecla CORRECTA!",0
    mensaje_error: db "', tecla INCORRECTA!",0
    buffer: times 10 db 0,0

main:
    limpiar_pantalla
    ;Imprimir interfaz
    imprimir welcomeText
    salto_linea
    ;Imprimir estructura de bloques
    imprimir blockStructure
    ;Espera la entrada del usuario
    entrada buffer
    xor bx, bx
    ;Imprime mensaje de error en caso de error
    imprimir mensaje_error
    ;Genera un loop hasta que el usuario presione la tecla correcta
    jmp main

;En caso de que la tecla sea correcta, se imprime el mensaje de exito y se finaliza el programa
correcto:
    imprimir mensaje_exitoso
    ret

.repeat:
    lodsb
    cmp al, 0
    je .done
    int 10h
    jmp .repeat
    
.done:
    ret

times 510 - ($-$$) db 0
dw 0xAA55