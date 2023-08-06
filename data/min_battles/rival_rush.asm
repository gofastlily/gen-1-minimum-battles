RivalRushRedTrainerData:
DEF _trainers = 0
	trainer_info OPP_RIVAL,    $00  ; Rival 1
	trainer_info OPP_RIVAL,    $01  ; Rival 2
	trainer_info OPP_RIVAL,    $02  ; Rival 3
	trainer_info OPP_RIVAL,    $03  ; Rival 4
	trainer_info OPP_RIVAL,    $04  ; Rival 5
	trainer_info OPP_RIVAL,    $05  ; Rival 6
	trainer_info OPP_RIVAL,    $06  ; Rival 7
	; End of the loop
	trainer_info OPP_LIST_END, OPP_LIST_END
DEF MIN_BATTLES_TRAINERS_RIVAL_RUSH EQU _trainers
