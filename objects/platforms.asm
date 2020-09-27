platformsprite:
    db 255
    db 255
    db 255
    db 255
    db 255
    db 255
    db 255
    db 255
;

platforms:
    db TRUE,14,90,10,16
    db TRUE,2,170,10,16
    db 255

PLATFORM_DATA_LENGTH equ 5

platform_init:

    ret



platform_draw:
    ret