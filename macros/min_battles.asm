; Trainer List: MinBattlesRedTrainerData
; Gym Leader List: MinBattlesRedGymLeaderData
; Gym Badges and TMs: ArenaLookupBadgeAndTM
; Elite Four List: MinBattlesRedEliteFourData
; Rivals List: RivalTeamData
; Battle Count: MIN_BATTLES_TRAINERS_RED
MACRO min_battles_game_types
	dw \1
	dw \2
	dw \3
	dw \4
	dw \5
	db \6
ENDM


; Trainer class: OPP_BUG_CATCHER
; Trainer number: $03
MACRO trainer_info
	db \1
	db \2
	DEF _trainers += 1
ENDM


; Badge: BIT_BOULDERBADGE
; TM: TM_BIDE
MACRO badge_and_tm
	db \1
	db \2
ENDM


; Trainer class: OPP_RIVAL1
; Trainer number 1: $01 <- Party when player picks starter one
; Trainer number 2: $02 <- Party when player picks starter two
; Trainer number 3: $03 <- Party when player picks starter three
; Trainer number 4: $04 <- Party when player picks starter four
; Trainer number 5: $05 <- Party when player picks starter four
; Trainer number 6: $06 <- Party when player picks starter four
; Trainer number 7: $07 <- Party when player picks starter five
; Trainer number 8: $08 <- Party when player picks starter five
; Trainer number 9: $09 <- Party when player picks starter five
MACRO rival_info
	db \1
	db \2
	db \3
	db \4
	db \5
	db \6
	db \7
	db \8
	db \9
	db \<10>
ENDM


OPP_GYM_LEAD                 EQU $fc
OPP_ELITE_FOUR               EQU $fd
OPP_RIVAL                    EQU $fe
OPP_LIST_END                 EQU $ff


MIN_BATTLES_RED              EQU 1
MIN_BATTLES_YELLOW           EQU 2
MIN_BATTLES_GYM_RUSH_RED     EQU 3
MIN_BATTLES_GYM_RUSH_YELLOW  EQU 4
MIN_BATTLES_BOSS_RUSH_RED    EQU 5
MIN_BATTLES_BOSS_RUSH_YELLOW EQU 6
