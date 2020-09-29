UI_COLOURS equ %01000100

ui_init:
    ld hl,0x5800
    ld b,UI_COLOURS
    call paint_base_attributes

    call init_ui_labels
    call refresh_ui_numbers
    ret


init_ui_labels:
    ld bc,15616
    ld d,CASH_LABEL_Y
    ld e,CASH_LABEL_X
    call GetCharAddr
    ld de,cash_string
    call PrintStr

    ld d,FARE_LABEL_Y
    ld e,FARE_LABEL_X
    call GetCharAddr
    ld de,fare_string
    call PrintStr

    ld d,DESTINATION_LABEL_Y
    ld e,DESTINATION_LABEL_X
    call GetCharAddr
    ld de,destination_string
    call PrintStr

    ret

refresh_ui_numbers:
    ld bc,15616
    ld d,CASH_Y
    ld e,CASH_10000_X
    call GetCharAddr
    ld a,(cash_10000)
    add a,ASCII_ZERO
    call PrintChar

    ld d,CASH_Y
    ld e,CASH_1000_X
    call GetCharAddr
    ld a,(cash_1000)
    add a,ASCII_ZERO
    call PrintChar

    ld d,CASH_Y
    ld e,CASH_100_X
    call GetCharAddr
    ld a,(cash_100)
    add a,ASCII_ZERO
    call PrintChar

    ld d,CASH_Y
    ld e,CASH_10_X
    call GetCharAddr
    ld a,(cash_10)
    add a,ASCII_ZERO
    call PrintChar

    ld d,CASH_Y
    ld e,CASH_1_X
    call GetCharAddr
    ld a,(cash_1)
    add a,ASCII_ZERO
    call PrintChar

    ;FARE

    ld d,FARE_Y
    ld e,FARE_1_X
    call GetCharAddr
    push hl
    ld hl,(customer_fare)
    ld a,h
    add a,ASCII_ZERO
    pop hl
    call PrintChar

    ;DESTINATION
    ld a,(customer_destination_platform)
    cp 0 
    ret z
    
    ld d,DESTINATION_LABEL_Y
    ld e,DESTINATION_1_X
    call GetCharAddr
    ld a,(customer_destination_platform)
    add a,ASCII_ZERO
    call PrintChar

    ret
;

;DE=yx
;A=(value)
draw_digit:
    ld bc,15616
    push af
    call GetCharAddr
    pop af
    add a,ASCII_ZERO
    call PrintChar  
    ret
; 





increment_cash1:
    ld a,(cash_1)
    inc a
    ld (cash_1),a 
    cp 9
    jp z, reset_cash_1
    
    ld d,CASH_Y
    ld e,CASH_1_X
    ld a,(cash_1)
    call draw_digit
    ret
reset_cash_1:
    call increment_cash10
    xor a
    ld (cash_1),a
    ld d,CASH_Y
    ld e,CASH_1_X
    ld a,(cash_1)
    call draw_digit
    ret

increment_cash10:
    ld a,(cash_10)
    cp 9
    jp nc,reset_cash10
    inc a
    ld (cash_10),a
    ld d,CASH_Y
    ld e,CASH_10_X
    ld a,(cash_10)
    call draw_digit
    ret

reset_cash10:
    call increment_cash100
    xor a
    ld (cash_10),a
    ld d,CASH_Y
    ld e,CASH_10_X
    ld a,(cash_10)
    call draw_digit
    
    ret

increment_cash100:
    ld a,(cash_100)
    cp 9
    jp z,reset_cash100
    inc a
    ld (cash_100),a
    ld d,CASH_Y
    ld e,CASH_100_X
    ld a,(cash_100)
    call draw_digit
    ret

reset_cash100:
    call increment_cash1000
    xor a
    ld (cash_100),a
    ld d,CASH_Y
    ld e,CASH_100_X
    ld a,(cash_100)
    call draw_digit
    
    ret

increment_cash1000:
    ld a,(cash_1000)
    cp 9
    jp z,reset_cash1000
    inc a
    ld (cash_1000),a
    ld d,CASH_Y
    ld e,CASH_1000_X
    ld a,(cash_1000)
    call draw_digit
    ret

reset_cash1000:
    call increment_cash10000
    xor a
    ld (cash_1000),a
    ld d,CASH_Y
    ld e,CASH_1000_X
    ld a,(cash_1000)
    call draw_digit
    
    ret

increment_cash10000:
    ld a,(cash_10000)
    cp 9
    ret z
    inc a
    ld (cash_10000),a
    ld d,CASH_Y
    ld e,CASH_10000_X
    ld a,(cash_10000)
    call draw_digit
    ret


decrement_cash100:
    ld a,(cash_100)
    cp 0
    jp z,dec_reset_cash100
    dec a
    ld (cash_100),a
    ld d,CASH_Y
    ld e,CASH_100_X
    ld a,(cash_100)
    call draw_digit
    ret

dec_reset_cash100:
    call decrement_cash1000
    ld a,9
    ld (cash_100),a
    ld d,CASH_Y
    ld e,CASH_100_X
    ld a,(cash_100)
    call draw_digit
    ret

decrement_cash1000:
    ld a,(cash_1000)
    cp 0
    jp z,dec_reset_cash1000
    dec a
    ld (cash_1000),a
    ld d,CASH_Y
    ld e,CASH_1000_X
    ld a,(cash_1000)
    call draw_digit
    ret

dec_reset_cash1000:
    call decrement_cash10000
    ld a,9
    ld (cash_1000),a
    ld d,CASH_Y
    ld e,CASH_1000_X
    ld a,(cash_1000)
    call draw_digit
    
    ret

decrement_cash10000:
    ld a,(cash_10000)
    cp 0
    ret z
    dec a
    ld (cash_10000),a
    ld d,CASH_Y
    ld e,CASH_10000_X
    ld a,(cash_10000)
    call draw_digit
    ret


;;;; DATA ;;;;;;;;;;



cash_string db 'CASH',0
CASH_LABEL_Y equ 1
CASH_LABEL_X equ 25
CASH_Y equ CASH_LABEL_Y+1
CASH_1_X equ 29
CASH_10_X equ 28
CASH_100_X equ 27
CASH_1000_X equ 26
CASH_10000_X equ 25


cash_1     db 0
cash_10    db 0
cash_100   db 0
cash_1000  db 0
cash_10000  db 0


FARE_LABEL_Y equ 4
FARE_LABEL_X equ 25
FARE_Y equ FARE_LABEL_Y
FARE_1_X equ 30


DESTINATION_LABEL_Y equ 8
DESTINATION_LABEL_X equ 27
DESTINATION_1_X equ 25
destination_string db 'plz!'





























