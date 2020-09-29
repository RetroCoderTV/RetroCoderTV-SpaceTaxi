main_menu_string db 'SPACE TAXI',0
game_over_string db 'GAME OVER',0


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
    ld e,10
    call GetCharAddr
    ld de,game_over_string
    call PrintStr

    call check_keys
    ld a,(keypressed_Space)
    cp TRUE
    jp z, program_start

    jp game_over_menu