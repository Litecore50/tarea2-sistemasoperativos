org 0x7C00
%include "boot2.asm"

start:
    jmp main
    welcomeText: db "Bienvenido a TutorMec, presione las teclas!" , 0,
    blockStructure: db "----  ----  ----  ----  ----", 10, 0x0D, 
                     db "|  |  |  |  |  |  |  |  |  |", 10, 0x0D,
                     db "----  ----  ----  ----  ----", 0
    letras: db " 'f' (Dedo indice izq) | 'p' (Dedo menique der) |'x' (Dedo anular izq) | 'u' (Dedo corazon der)", 0,
    mensaje_exitoso: db "Tecla CORRECTA!",0
    mensaje_error: db "Tecla INCORRECTA!",0
    buffer: times 10 db 0,0

correcto:
    limpiar_pantalla
    imprimir mensaje_exitoso
    ret
main:
    ;Imprimir interfaz
    imprimir welcomeText
    salto_linea
    imprimir blockStructure
    salto_linea
    imprimir letras
    salto_linea
    entrada buffer
    xor bx, bx
    limpiar_pantalla
    imprimir mensaje_error
    salto_linea
    jmp main
TIMES 510 - ($ - $$) db 0
dw 0xAA55