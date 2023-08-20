; Trainer class: OPP_BUG_CATCHER
; Trainer number: $03
MinBattlesRedTrainerData:
DEF _trainers = 0
	; Oak's Lab, 0
	trainer_info OPP_RIVAL,    $00  ; Rival 1
	; Viridian Forest, 1
	trainer_info OPP_BUG_CATCHER,    $03
	; Pewter Gym, 2
	trainer_info OPP_GYM_LEAD, $00  ; Brock
	; Route 3, 3
	trainer_info OPP_BUG_CATCHER,    $04
	trainer_info OPP_YOUNGSTER,      $03
	trainer_info OPP_LASS,           $02  ; 5
	trainer_info OPP_BUG_CATCHER,    $06
	; Mt. Moon, 7
	trainer_info OPP_ROCKET,         $01
	trainer_info OPP_SUPER_NERD,     $02
	; Route 24, 9
	trainer_info OPP_RIVAL,    $01  ; Rival 2
	trainer_info OPP_BUG_CATCHER,    $09  ; 10
	trainer_info OPP_LASS,           $08
	trainer_info OPP_YOUNGSTER,      $04
	trainer_info OPP_LASS,           $07
	trainer_info OPP_JR_TRAINER_M,   $03
	trainer_info OPP_ROCKET,         $06  ; 15
	; Route 25, 16
	trainer_info OPP_HIKER,          $04
	trainer_info OPP_LASS,           $09
	trainer_info OPP_HIKER,          $03
	trainer_info OPP_LASS,           $0a
	trainer_info OPP_JR_TRAINER_F,   $01  ; 20
	; Cerulean City, 21
	trainer_info OPP_GYM_LEAD, $01  ; Misty
	trainer_info OPP_ROCKET,         $05
	; Route 6, 23
	trainer_info OPP_JR_TRAINER_F,   $03
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
	trainer_info OPP_POKEMANIAC,     $07  ; 30
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
	trainer_info OPP_ROCKET,         $13
	trainer_info OPP_ROCKET,         $14
	trainer_info OPP_ROCKET,         $15
	; Celadon Gym, 44
	trainer_info OPP_BEAUTY,         $03
	trainer_info OPP_GYM_LEAD, $03  ; Erika
	; Fuschia Gym, 46
	trainer_info OPP_JUGGLER,        $03
	trainer_info OPP_JUGGLER,        $04
	trainer_info OPP_GYM_LEAD, $04  ; Koga
	; Silph Co., 49
	trainer_info OPP_ROCKET,         $1c
	trainer_info OPP_RIVAL,    $04  ; Rival 5
	trainer_info OPP_ROCKET,         $29
	trainer_info OPP_GIOVANNI,       $02
	; Saffron Gym, 53
	trainer_info OPP_GYM_LEAD, $05  ; Sabrina
	; Cinnabar Gym, 54
	trainer_info OPP_GYM_LEAD, $06  ; Blaine
	; Viridian Gym, 55
	trainer_info OPP_COOLTRAINER_M,  $09  ; 55
	trainer_info OPP_BLACKBELT,      $08
	trainer_info OPP_GYM_LEAD, $07  ; Giovanni (Gym)
	; Route 22, 58
	trainer_info OPP_RIVAL,    $05  ; Rival 6
	; Elite Four, 59
	trainer_info OPP_LORELEI,        $01
	trainer_info OPP_BRUNO,          $01  ; 60
	trainer_info OPP_AGATHA,         $01
	trainer_info OPP_LANCE,          $01
	; Champion, 63
	trainer_info OPP_RIVAL,    $06  ; Rival 7
	; End of the loop
	trainer_info OPP_LIST_END, OPP_LIST_END
DEF MIN_BATTLES_TRAINERS_RED EQU _trainers
