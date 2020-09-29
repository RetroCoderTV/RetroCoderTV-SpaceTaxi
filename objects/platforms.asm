
;all platforms 8px height
;ID (0=dead),x,y,w
platforms:   
    db 1,2,40,4 
    db 2,22,40,4 
    db 3,2,80,4  
    db 4,22,80,4
    db 5,6,110,5
    db 6,17,110,5
    db 7,2,160,3
    db 8,23,160,3
    db 9,2,0,24 ;roof is number 9 for platform label purposes
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
    
    ;draw platform:
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

    ;draw platform number:
    ld a,(ix)
    cp 9
    jp z,plats_draw_next
    ld hl,0x3d80
    ld d,0
    ld e,(ix)
    add hl,de ;add offset x1
    add hl,de 
    add hl,de 
    add hl,de 
    add hl,de 
    add hl,de 
    add hl,de 
    add hl,de ;add offset x8
  
    ld bc,hl
    ld d,(ix+1)
    inc d
    ld e,(ix+2)
    call drawsprite8_8_overwrite
plats_draw_next:
    ld de,PLATFORM_DATA_LENGTH
    add ix,de
    jp plats_draw_start
