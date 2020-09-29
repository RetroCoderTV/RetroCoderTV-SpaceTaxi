
PY_DEFAULT equ 0x1A00
PX_DEFAULT equ 0x0900

py dw PY_DEFAULT
px dw PX_DEFAULT

vy dw 0x0000
vx dw 0x0000

ty dw PY_DEFAULT
tx dw PX_DEFAULT


;todo: figure out why the negative numbers need to be double the positive ones.

THRUST_FORCE equ -64*2 ;%1111111111000000
THRUST_MAX equ -16
THRUST_SIDE_FORCE equ 52
THRUST_SIDE_MAX equ 1
GRAVITY_MAX equ 16 ;upper byte
GRAVITY_FORCE equ 32*2; %0000000000011111  

player_facing_right db TRUE

player_sprite_frame db 0
PLAYER_SPRITE_SIZE equ 3*8

player_grounded db FALSE

player_is_alive db TRUE


player_dead_time db 0
PLAYER_DEATH_DELAY equ 20



; ASM data file from a ZX-Paintbrush picture with 24 x 8 pixels (= 3 x 1 characters)
; line based output of pixel data:
playersprite_right:
    db %00011111, %10000000, %00000000
    db %00110010, %01000000, %00000000
    db %01100010, %00100000, %00000000
    db %11111111, %11111110, %00000000
    db %11111111, %11111110, %00000000
    db %10000111, %11000010, %00000000
    db %10110111, %11011010, %00000000
    db %00110000, %00011000, %00000000

    db %00000111, %11100000, %00000000
    db %00001100, %10010000, %00000000
    db %00011000, %10001000, %00000000
    db %00111111, %11111111, %10000000
    db %00111111, %11111111, %10000000
    db %00100001, %11110000, %10000000
    db %00101101, %11110110, %10000000
    db %00001100, %00000110, %00000000

    db %00000001, %11111000, %00000000
    db %00000011, %00100100, %00000000
    db %00000110, %00100010, %00000000
    db %00001111, %11111111, %11100000
    db %00001111, %11111111, %11100000
    db %00001000, %01111100, %00100000
    db %00001011, %01111101, %10100000
    db %00000011, %00000001, %10000000

    db %00000000, %01111110, %00000000
    db %00000000, %11001001, %00000000
    db %00000001, %10001000, %10000000
    db %00000011, %11111111, %11111000
    db %00000011, %11111111, %11111000
    db %00000010, %00011111, %00001000
    db %00000010, %11011111, %01101000
    db %00000000, %11000000, %01100000

    db %00000000, %00011111, %10000000
    db %00000000, %00110010, %01000000
    db %00000000, %01100010, %00100000
    db %00000000, %11111111, %11111110
    db %00000000, %11111111, %11111110
    db %00000000, %10000111, %11000010
    db %00000000, %10110111, %11011010
    db %00000000, %00110000, %00011000
;
;
;
playersprite_left:
    db %00000000, %00000001, %11111000
    db %00000000, %00000010, %01001100
    db %00000000, %00000100, %01000110
    db %00000000, %01111111, %11111111
    db %00000000, %01111111, %11111111
    db %00000000, %01000011, %11100001
    db %00000000, %01011011, %11101101
    db %00000000, %00011000, %00001100

    db %00000000, %00000111, %11100000
    db %00000000, %00001001, %00110000
    db %00000000, %00010001, %00011000
    db %00000001, %11111111, %11111100
    db %00000001, %11111111, %11111100
    db %00000001, %00001111, %10000100
    db %00000001, %01101111, %10110100
    db %00000000, %01100000, %00110000

    db %00000000, %00011111, %10000000
    db %00000000, %00100100, %11000000
    db %00000000, %01000100, %01100000
    db %00000111, %11111111, %11110000
    db %00000111, %11111111, %11110000
    db %00000100, %00111110, %00010000
    db %00000101, %10111110, %11010000
    db %00000001, %10000000, %11000000

    db %00000000, %01111110, %00000000
    db %00000000, %10010011, %00000000
    db %00000001, %00010001, %10000000
    db %00011111, %11111111, %11000000
    db %00011111, %11111111, %11000000
    db %00010000, %11111000, %01000000
    db %00010110, %11111011, %01000000
    db %00000110, %00000011, %00000000

    db %00000001, %11111000, %00000000
    db %00000010, %01001100, %00000000
    db %00000100, %01000110, %00000000
    db %01111111, %11111111, %00000000
    db %01111111, %11111111, %00000000
    db %01000011, %11100001, %00000000
    db %01011011, %11101101, %00000000
    db %00011000, %00001100, %00000000
    
;
;

player_reset:
    xor a
    ld (player_dead_time),a
    ld a,TRUE
    ld (player_is_alive),a
    ld hl,PX_DEFAULT
    ld (px),hl
    ld (tx),hl
    ld hl,PY_DEFAULT
    ld (py),hl
    ld (ty),hl
    ld hl,0
    ld (vx),hl
    ld (vy),hl
    ret

player_update:
    ld a,(player_is_alive)
    cp TRUE
    jp nz,plyr_dead_upd


    call check_keys

    call plyr_apply_gravity

    ld a,(keypressed_W)
    cp TRUE
    call z,plyr_apply_thrusters

    ld a,(keypressed_D)
    cp TRUE
    call z,plyr_apply_thrusters_r

    ld a,(keypressed_A)
    cp TRUE
    call z,plyr_apply_thrusters_l

    call set_target_pos


    call do_move

    ld a,FALSE
    ld (player_grounded),a

    ld ix,platforms
    call plyr_chk_landing_collision

    ld ix,platforms
    call plyr_chk_collision_platform
    ret


plyr_dead_upd:
    ld a,(player_dead_time)
    inc a
    ld (player_dead_time),a
    cp PLAYER_DEATH_DELAY
    jp nc, game_over_menu
    ret

set_target_pos:
    ld hl,(px)
    ld (tx),hl
    ld hl,(py)
    ld (py),hl

    ld hl,(tx)
    ld de,(vx)
    add hl,de
    ld (tx),hl

    ld hl,ty
    inc hl
    ld d,(hl)
    ld hl,vy
    inc hl
    ld a,(hl)
    add a,d
    ld hl,ty
    inc hl
    ld (hl),a
    ret


do_move:
    ld hl,(tx)
    ld (px),hl

    ld hl,(ty)
    ld (py),hl
    ret
    
player_draw:
    ld hl,px
    inc hl
    ld d,(hl)
    ld hl,py
    inc hl
    ld e,(hl)
    ld a,e
    cp 192
    ret nc

    ld a,(player_is_alive)
    cp TRUE
    jp nz,p_dodraw_dead


    ld a,(player_facing_right)
    cp TRUE
    jp z, p_dodraw_r

p_dodraw_l:
    ld hl,px
    ld a,(hl)
    ld bc,playersprite_left+(PLAYER_SPRITE_SIZE*4)
    cp THRUST_SIDE_FORCE*1
    push af
    call nc,setplyrsprite_l2
    pop af
    cp THRUST_SIDE_FORCE*2
    push af
    call nc,setplyrsprite_l3
    pop af
    cp THRUST_SIDE_FORCE*3
    push af
    call nc,setplyrsprite_l4
    pop af
    cp THRUST_SIDE_FORCE*4
    call nc,setplyrsprite_l5   
    
    call drawsprite24_8
    ret
p_dodraw_r:
    ld hl,px
    ld a,(hl)
    ld bc,playersprite_right
    cp THRUST_SIDE_FORCE*1
    push af
    call nc,setplyrsprite_r2
    pop af
    cp THRUST_SIDE_FORCE*2
    push af
    call nc,setplyrsprite_r3
    pop af
    cp THRUST_SIDE_FORCE*3
    push af
    call nc,setplyrsprite_r4
    pop af
    cp THRUST_SIDE_FORCE*4
    call nc,setplyrsprite_r5

    call drawsprite24_8
    ret
;
p_dodraw_dead:
    call setplyrsprite_dead
    call drawsprite16_8
    ret

setplyrsprite_l2:
    ld bc,playersprite_left+(PLAYER_SPRITE_SIZE*3)
    ret

setplyrsprite_l3:
    ld bc,playersprite_left+(PLAYER_SPRITE_SIZE*2)
    ret
setplyrsprite_l4:
    ld bc,playersprite_left+(PLAYER_SPRITE_SIZE*1)
    ret
setplyrsprite_l5:
    ld bc,playersprite_left
    ret

setplyrsprite_r2:
    ld bc,playersprite_right+PLAYER_SPRITE_SIZE
    ret

setplyrsprite_r3:
    ld bc,playersprite_right+(PLAYER_SPRITE_SIZE*2)
    ret
setplyrsprite_r4:
    ld bc,playersprite_right+(PLAYER_SPRITE_SIZE*3)
    ret
setplyrsprite_r5:
    ld bc,playersprite_right+(PLAYER_SPRITE_SIZE*4)
    ret

setplyrsprite_dead:
    push de
    call rand
    ld b,a
    call rand
    ld c,a
    pop de
    ret


plyr_apply_gravity:
    ld a,(player_grounded)
    cp TRUE
    ret z

    ld hl,vy
    inc hl
    ld a,(hl)
    cp GRAVITY_MAX
    ret z

    ld hl,(vy)
    ld de,GRAVITY_FORCE
    add hl,de
    ld (vy),hl
    ret
;


; Unsigned

; If A == N, then Z flag is set.
; If A != N, then Z flag is reset.
; If A < N, then C flag is set.
; If A >= N, then C flag is reset.

; Signed

; If A == N, then Z flag is set.
; If A != N, then Z flag is reset.
; If A < N, then S and P/V are different.
; A >= N, then S and P/V are the same.

plyr_apply_thrusters:
    ld hl,vy
    inc hl
    ld a,(hl)
    cp THRUST_MAX
    ret z

    ld hl,(vy)
    ld de,THRUST_FORCE
    add hl,de
    ld (vy),hl
    ret

plyr_apply_thrusters_r:
    ld a,(player_grounded)
    cp TRUE
    ret z

    ld a,TRUE
    ld (player_facing_right),a 
    ld hl,vx
    inc hl
    ld a,(hl)
    cp THRUST_SIDE_MAX
    ret z

    ld hl,(vx)
    ld de,THRUST_SIDE_FORCE
    add hl,de
    ld (vx),hl
    ret
plyr_apply_thrusters_l:
    ld a,(player_grounded)
    cp TRUE
    ret z

    ld a,FALSE
    ld (player_facing_right),a 

    ld hl,vx
    inc hl
    ld a,(hl)
    cp -THRUST_SIDE_MAX*2 ;for some reason needed to double this
    ret z

    ld hl,(vx)
    ld de,-THRUST_SIDE_FORCE
    add hl,de
    ld (vx),hl
    ret




;Collision prevention, checks the next position will result in collision or not
;IX=platforms
plyr_chk_landing_collision:
    ;check player is moving down
    ld hl,vy
    inc hl
    ld a,(hl)
    bit 7,a
    ret nz

    ;check for end of platforms array
    ld a,(ix)
    cp 255
    ret z

    ;check player missed platform
    ;passed the right side of platform
    ld hl,tx
    inc hl
    ld a,(hl)
    add a,1
    ld b,a
    ld a,(ix+1)
    add a,(ix+3)
    cp b
    jp c, p_chk_landing_next

    ;passed the left side of platform
    ld a,(ix+1)
    ld b,a
    ld hl,tx
    inc hl
    ld a,(hl)
    add a,2 ;pw
    cp b
    jp c, p_chk_landing_next

    ;passed the bottom of platform
    ld hl,ty
    inc hl
    ld a,(hl)
    ld b,a
    ld a,(ix+2)
    add a,8 ;platform height
    cp b
    jp c, p_chk_landing_next

    ;passed the top of platform
    ld a,(ix+2)
    ld b,a
    ld hl,ty
    inc hl
    ld a,(hl)
    add a,8 ;ph
    cp b
    jp c, p_chk_landing_next

    ; collision...
    call player_set_grounded
p_chk_landing_next:
    ld de,PLATFORM_DATA_LENGTH
    add ix,de
    jp plyr_chk_landing_collision

    



player_set_grounded:
    ;set v=0
    ld hl,0
    ld (vy),hl
    ld hl,0
    ld (vx),hl
    
    ;set as grounded
    ld a,TRUE
    ld (player_grounded),a

    ;snap to sitting on platform
    ld a,(ix+2)
    sub 8 ;ph
    ld hl,py
    inc hl
    ld (hl),a
    ;also set ty = py (stops the 'dip' as we take off)
    ld hl,(py)
    ld (ty),hl

    ld a,(customer_start_platform)
    cp (ix)
    call z,customer_trigger_ride

    ld a,(customer_destination_platform)
    cp (ix)
    call z,customer_end_ride

    ret




;Collision prevention, checks the next position will result in collision or not
;IX=platforms
plyr_chk_collision_platform:
    ld a,(player_grounded)
    cp TRUE
    ret z

    ;check for end of platforms array
    ld a,(ix)
    cp 255
    ret z
;check player missed platform
    ;passed the right side of platform
    ld hl,px
    inc hl
    ld a,(hl)
    add a,1
    ld b,a
    ld a,(ix+1)
    add a,(ix+3)
    cp b
    jp c, p_coll_platform_gonext

    ;passed the left side of platform
    ld a,(ix+1)
    ld b,a
    ld hl,px
    inc hl
    ld a,(hl)
    add a,2 ;pw
    cp b
    jp c, p_coll_platform_gonext

    ;passed the bottom of platform
    ld hl,py
    inc hl
    ld a,(hl)
    ld b,a
    ld a,(ix+2)
    add a,8 ;platform height
    cp b
    jp c, p_coll_platform_gonext

    ;passed the top of platform
    ld a,(ix+2)
    ld b,a
    ld hl,py
    inc hl
    ld a,(hl)
    add a,4 ;ph
    cp b
    jp c, p_coll_platform_gonext

    ; collision...
    call player_kill
p_coll_platform_gonext:
    ld de,PLATFORM_DATA_LENGTH
    add ix,de
    jp plyr_chk_collision_platform








player_kill:
    ld a,FALSE
    ld (player_is_alive),a
    ret