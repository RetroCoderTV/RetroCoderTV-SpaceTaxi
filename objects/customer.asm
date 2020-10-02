customersprite:
    db %00011100
    db %00101010
    db %00111110
    db %10100100
    db %11111111
    db %00111100
    db %00111100
    db %01100110

customer_state db NOTHING
customer_start_platform db 6
customer_destination_platform db 0
customer_y db 0
customer_x db 0
CUSTOMER_DEFAULT_FARE equ 0x0a00
customer_fare dw CUSTOMER_DEFAULT_FARE



;customer states:
NOTHING equ 0
WAITING equ 1
RIDING equ 2





customer_new:
    ld a,(customer_state)
    cp NOTHING

    ld hl,customer_fare
    xor a
    ld (hl),a
    inc hl
    ld (hl),0x0a
    ret nz

cust_new_chooserandomplat:
    call rand
    and 7 ;there are 8 platforms (0 platform does not count it is the roof)
    add a,1
    ld b,a
    ld a,(customer_destination_platform)
    cp b
    jp z,cust_new_chooserandomplat ;if platform = start platform, roll again
    ld a,b
    ld (customer_start_platform),a

    ld ix,platforms
cust_new_getpos:
    ld hl,CUSTOMER_DEFAULT_FARE
    ld (customer_fare),hl

    ld a,(ix)
    ld b,a
    ld a,(customer_start_platform)
    cp b
    jp nz, cust_new_getpos_next

    ld a,(ix+1)
    add a,1
    ld (customer_x),a

    ld a,(ix+2)
    sub 8
    ld (customer_y),a

    ld a,WAITING
    ld (customer_state),a

    

    ret
cust_new_getpos_next:
    ld de,PLATFORM_DATA_LENGTH
    add ix,de
    jp cust_new_getpos



customer_update:
    ld a,(customer_state)
    cp NOTHING
    push af
    call z, customer_new
    pop af
    ret z


    
    call cust_decrease_fare

    call refresh_ui_numbers

    ;if fare = 0, lose life
    ld hl,customer_fare
    inc hl
    ld a,(hl)
    cp 0
    call z,player_kill

    ret


cust_decrease_fare:
    ld a,(player_is_alive)
    cp TRUE
    ret nz

    ld hl,(customer_fare)
    dec hl
    dec hl
    dec hl
    dec hl
    ld (customer_fare),hl
    ret



customer_draw:
    ld a,(customer_state)
    cp WAITING
    ret nz

    ld de,(customer_y)
    ld bc,customersprite
    call drawsprite8_8

    ret




customer_trigger_ride:
    ld a,(customer_state)
    cp WAITING
    ret nz
cust_chooserandomplat:
    call rand
    and 7 ;there are 8 platforms (0 platform does not count it is the roof)
    add a,1
    ld b,a
    ld a,(customer_start_platform)
    cp b
    jp z,cust_chooserandomplat ;if platform = start platform, roll again
    ld a,b
    ld (customer_destination_platform),a


    ld a,RIDING
    ld (customer_state),a

    ret





customer_end_ride:
    ld a,(customer_state)
    cp RIDING
    ret nz

    ; todo: add remaining fare to players score

    ld a,NOTHING
    ld (customer_state),a

    call customer_new


    ret