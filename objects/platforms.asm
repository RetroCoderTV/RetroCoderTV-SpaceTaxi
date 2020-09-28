platforms:
    db 1,2,0,24    
    db 2,20,60,4  
    db 3,2,100,4  
    db 4,8,170,8
    db 255
PLATFORM_DATA_LENGTH equ 4


platformsprites:
    db %11111111
    db %11111111
    db %10101010
    db %01010101
    db %10101010
    db %01010101
    db %11111111
    db %11111111




platforms_init:

    ret



platforms_draw:
    ld ix,platforms
plats_draw_start:
    ld a,(ix)
    cp 255
    ret z
    cp FALSE
    jp z,plats_draw_next
    ld b,(ix+3)
    ld c,0
plats_draw_cells:
    ld a,(ix+1)
    add a,c
    ld d,a
    ld e,(ix+2)
    ld a,c
    add a,1
    ld c,a
    push bc
    ld bc,platformsprites
    call drawsprite8_8
    pop bc
    djnz plats_draw_cells
plats_draw_next:
    ld de,PLATFORM_DATA_LENGTH
    add ix,de
    jp plats_draw_start
    ret