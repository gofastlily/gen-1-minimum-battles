; Trainer class: OPP_BUG_CATCHER
; Trainer number: $03
MinBattlesYellowTrainerData:
DEF _trainers = 0
	; Oak's Lab, 0
	trainer_info OPP_RIVAL,    $00  ; Rival 1
	; Viridian Forest, 1
	trainer_info OPP_BUG_CATCHER,    $11  ; Changed in Yellow
	; Pewter Gym, 2
	trainer_info OPP_GYM_LEAD, $00  ; Brock
	; Route 3, 3
	trainer_info OPP_BUG_CATCHER,    $04
	trainer_info OPP_YOUNGSTER,      $03
	trainer_info OPP_LASS,           $02  ; 5
	trainer_info OPP_BUG_CATCHER,    $06
	; Mt. Moon, 7
	trainer_info OPP_SUPER_NERD,     $02
	trainer_info OPP_ROCKET,         $2a  ; Jessie and James 1
	; Route 23, 9
	trainer_info OPP_RIVAL,    $01  ; Rival 2
	trainer_info OPP_BUG_CATCHER,    $09  ; 10
	trainer_info OPP_LASS,           $09
	trainer_info OPP_YOUNGSTER,      $04
	trainer_info OPP_LASS,           $0a
	trainer_info OPP_JR_TRAINER_M,   $02
	trainer_info OPP_ROCKET,         $06  ; 15
	; Route 24, 16
	trainer_info OPP_HIKER,          $04
	trainer_info OPP_LASS,           $0b
	trainer_info OPP_HIKER,          $03
	trainer_info OPP_LASS,           $0c
	trainer_info OPP_JR_TRAINER_F,   $01  ; 20
	; Cerulean City, 21
	trainer_info OPP_GYM_LEAD, $01  ; Misty
	trainer_info OPP_ROCKET,         $05
	; Route 6, 23
	trainer_info OPP_JR_TRAINER_F,   $19  ; Changed in Yellow
	trainer_info OPP_JR_TRAINER_M,   $05
	; S.S. Anne, 25
	trainer_info OPP_RIVAL,    $02  ; Rival 3
	; Vermillion City, 26
	trainer_info OPP_GYM_LEAD, $02  ; Lt. Surge
	; Route 9, 27
	trainer_info OPP_JR_TRAINER_F,   $05
	trainer_info OPP_BUG_CATCHER,    $0e
	trainer_info OPP_JR_TRAINER_F,   $06
	; Rock Tunnel, 30
	trainer_info OPP_POKEMANIAC,     $07
	trainer_info OPP_POKEMANIAC,     $05
	trainer_info OPP_JR_TRAINER_F,   $0a
	trainer_info OPP_POKEMANIAC,     $04
	trainer_info OPP_HIKER,          $09
	trainer_info OPP_JR_TRAINER_F,   $12  ; 35
	; Route 8, 36
	trainer_info OPP_LASS,           $10
	; Pokemon Tower, 37
	trainer_info OPP_RIVAL,    $03  ; Rival 4
	trainer_info OPP_CHANNELER,      $0A
	trainer_info OPP_CHANNELER,      $14
	trainer_info OPP_CHANNELER,      $15  ; 40
	trainer_info OPP_ROCKET,         $2c  ; Jessie and James 3
	; Celadon Gym, 42
	trainer_info OPP_BEAUTY,         $03
	trainer_info OPP_GYM_LEAD, $03  ; Erika
	; Fuschia Gym, 44
	trainer_info OPP_JUGGLER,        $03
	trainer_info OPP_JUGGLER,        $04  ; 45
	trainer_info OPP_GYM_LEAD, $04  ; Koga
	; Silph Co., 47
	trainer_info OPP_ROCKET,         $1c
	trainer_info OPP_RIVAL,    $04  ; Rival 5
	trainer_info OPP_ROCKET,         $2d  ; Jessie and James 4
	trainer_info OPP_GIOVANNI,       $05  ; Changed in Yellow
	; Saffron Gym, 51
	trainer_info OPP_GYM_LEAD, $05  ; Sabrina
	; Cinnabar Gym, 52
	trainer_info OPP_GYM_LEAD, $06  ; Blaine
	; Viridian Gym, 53
	trainer_info OPP_COOLTRAINER_M,  $09
	trainer_info OPP_BLACKBELT,      $08
	trainer_info OPP_GYM_LEAD, $07  ; Giovanni (Gym)
	; Route 22, 56
	trainer_info OPP_RIVAL,    $05  ; Rival 6
	; Elite Four, 57
	trainer_info OPP_ELITE_FOUR, $00
	trainer_info OPP_ELITE_FOUR, $01
	trainer_info OPP_ELITE_FOUR, $02
	trainer_info OPP_ELITE_FOUR, $03  ; 60
	; Champion, 61
	trainer_info OPP_RIVAL,    $06  ; Rival 7
	; End of the loop
	trainer_info OPP_LIST_END, OPP_LIST_END
DEF MIN_BATTLES_TRAINERS_YELLOW EQU _trainers
