MinBattlesBossRushTrainerData:
DEF _trainers = 0
	trainer_info OPP_RIVAL,      $00  ; Rival 1
	trainer_info OPP_GYM_LEAD,   $00  ; Brock
	trainer_info OPP_RIVAL,      $01  ; Rival 2
	trainer_info OPP_GYM_LEAD,   $01  ; Misty
	trainer_info OPP_RIVAL,      $02  ; Rival 3
	trainer_info OPP_GYM_LEAD,   $02  ; Lt. Surge
	trainer_info OPP_RIVAL,      $03  ; Rival 4
	trainer_info OPP_GYM_LEAD,   $03  ; Erika
	trainer_info OPP_GYM_LEAD,   $04  ; Koga
	trainer_info OPP_RIVAL,      $04  ; Rival 5
	trainer_info OPP_GYM_LEAD,   $05  ; Sabrina
	trainer_info OPP_GYM_LEAD,   $06  ; Blaine
	trainer_info OPP_GYM_LEAD,   $07  ; Giovanni (Gym)
	trainer_info OPP_RIVAL,      $05  ; Rival 6
	trainer_info OPP_ELITE_FOUR, $00  ; Lorelei
	trainer_info OPP_ELITE_FOUR, $01  ; Bruno
	trainer_info OPP_ELITE_FOUR, $02  ; Agatha
	trainer_info OPP_ELITE_FOUR, $03  ; Lance
	trainer_info OPP_RIVAL,      $06  ; Rival 7
	trainer_info OPP_RIVAL,      $07  ; Professor Oak
	; End of the loop
	trainer_info OPP_LIST_END, OPP_LIST_END
DEF MIN_BATTLES_TRAINERS_BOSS_RUSH EQU _trainers
