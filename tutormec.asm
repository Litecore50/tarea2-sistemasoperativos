%include "tutormec_lib.asm"
start:
    ;Hace todos los cambios de direcciones de los registros
    mov ax, 07C0h
    add ax, 288
    mov ss, ax
    mov sp, 4096
    
    mov ax, 07C0h
    mov ds, ax

    mov si, welcomeText
    ;Llama al main
    call main    ; main
    jmp $
    welcomeText db  "Bienvenido a TutorMec!", 10, 0x0D, \
     		        "  f p  h x y  u", 10, 0x0D, \
                    "----|----|----|---- ----", 10, 0x0D, \
                    "|  |||  |||  |||  | |  |", 10, 0x0D, \
                    "----V----V----V---- ----", 10, 0x0D, \
                    "'p'(Menique der)", 10, 0x0D, \
                    "'x'(Anular izq)", 10, 0x0D, \
                    "'u'(Corazon der)", 10, 0x0D, \
                    "Tecla presionada: '", 0
    mensaje_exitoso: db "', tecla CORRECTA!",0
    mensaje_error: db "', tecla INCORRECTA o impacta con un bloque!",0
    
    buffer: times 10 db 0,0


printStr:
    mov ah, 0Eh

.repeat:
    lodsb
    cmp al, 0
    je .done
    int 10h
    jmp .repeat
    
.done:
    ret
    
    
main:
    tutormec
    
;En caso de que la tecla sea correcta, se imprime el mensaje de exito y se finaliza el programa
correcto:
    imprimir mensaje_exitoso
    call limpiar_pantalla
    jmp start

limpiar_pantalla:
    mov cx, 35
    loop_lineas:
        cmp cx, 20
        jz end_loop
        dec cx
        salto_linea
        jmp loop_lineas
    end_loop:
        salto_linea

times 510 - ($-$$) db 0
dw 0xAA55
