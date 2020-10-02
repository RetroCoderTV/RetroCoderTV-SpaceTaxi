main_menu_string db 'SPACE TAXI',0
; game_over_string db 'GAME OVER',0



go_0 db 'G',0
go_1 db 'GR',0
go_2 db 'GAR',0
go_3 db 'GAMR',0
go_4 db 'GAMER',0
go_5 db 'GAME R',0
go_6 db 'GAME OR',0
go_7 db 'GAME OVR',0
go_8 db 'GAME OVER',0
go_end db 255


go_finished db FALSE


main_menu:
    call check_keys

    ld a,(keypressed_Space_Held)
    cp TRUE
    jp z, main_menu

    call rand

    ld bc,15616
    ld d,10
    ld e,10
    call GetCharAddr
    ld de,main_menu_string
    call PrintStr

    ld a,(keypressed_Space)
    cp TRUE
    jp z, begin_game

    jp main_menu


game_over_menu:
    ld bc,15616
    ld d,10
    ld e,8
    call GetCharAddr
    ld de,go_8
    call PrintStr

    call check_keys
    ld a,(keypressed_Space)
    cp TRUE
    jp z, program_start

    
    

    jp game_over_menu

    
    