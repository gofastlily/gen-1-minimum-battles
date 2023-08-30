MinBattlesMenu:
	call ClearMenuExtra
	ld hl, MinBattlesChoicesList
	call MenuCore
	ret


MinBattlesChoicesList:
	menu_choice Determine_MinBattlesChoice_RedBlue,         Action_MinBattlesChoice_RedBlue,         Text_MinBattlesChoice_RedBlue
	menu_choice Determine_MinBattlesChoice_Yellow,          Action_MinBattlesChoice_Yellow,          Text_MinBattlesChoice_Yellow
	menu_choice Determine_MinBattlesChoice_GymRushRedBlue,  Action_MinBattlesChoice_GymRushRedBlue,  Text_MinBattlesChoice_GymRushRedBlue
	menu_choice Determine_MinBattlesChoice_GymRushYellow,   Action_MinBattlesChoice_GymRushYellow,   Text_MinBattlesChoice_GymRushYellow
	menu_choice Determine_MinBattlesChoice_BossRushRedBlue, Action_MinBattlesChoice_BossRushRedBlue, Text_MinBattlesChoice_BossRushRedBlue
	menu_choice Determine_MinBattlesChoice_BossRushYellow,  Action_MinBattlesChoice_BossRushYellow,  Text_MinBattlesChoice_BossRushYellow
	dw MENU_CHOICES_LIST_END


Determine_MinBattlesChoice_RedBlue:
	ld a, [wBeatMinBattles]
	bit 7, a
	ret


Action_MinBattlesChoice_RedBlue:
	ld a, MIN_BATTLES_RED
	ld [wMinBattlesGameType], a
	ret


Text_MinBattlesChoice_RedBlue:
	db "RED/BLUE@"


Determine_MinBattlesChoice_Yellow:
	jp AlwaysShowMenuItem


Action_MinBattlesChoice_Yellow:
	ld a, MIN_BATTLES_YELLOW
	ld [wMinBattlesGameType], a
	ret


Text_MinBattlesChoice_Yellow:
	db "YELLOW@"


Determine_MinBattlesChoice_GymRushRedBlue:
	ld a, [wBeatMinBattlesTwo]
	and %11000000
	cp %11000000
	call InvertZeroFlag
	ret


Action_MinBattlesChoice_GymRushRedBlue:
	ld a, MIN_BATTLES_GYM_RUSH_RED
	ld [wMinBattlesGameType], a
	ret


Text_MinBattlesChoice_GymRushRedBlue:
	db "GYM RUSH RB@"


Determine_MinBattlesChoice_GymRushYellow:
	ld a, [wBeatMinBattlesTwo]
	and %11000000
	cp %11000000
	call InvertZeroFlag
	ret


Action_MinBattlesChoice_GymRushYellow:
	ld a, MIN_BATTLES_GYM_RUSH_YELLOW
	ld [wMinBattlesGameType], a
	ret


Text_MinBattlesChoice_GymRushYellow:
	db "GYM RUSH Y@"


Determine_MinBattlesChoice_BossRushRedBlue:
	ld a, [wBeatMinBattlesTwo]
	and %11110000
	cp %11110000
	call InvertZeroFlag
	ret


Action_MinBattlesChoice_BossRushRedBlue:
	ld a, MIN_BATTLES_BOSS_RUSH_RED
	ld [wMinBattlesGameType], a
	ret


Text_MinBattlesChoice_BossRushRedBlue:
	db "BOSS RUSH RB@"


Determine_MinBattlesChoice_BossRushYellow:
	ld a, [wBeatMinBattlesTwo]
	and %11110000
	cp %11110000
	call InvertZeroFlag
	ret


Action_MinBattlesChoice_BossRushYellow:
	ld a, MIN_BATTLES_BOSS_RUSH_YELLOW
	ld [wMinBattlesGameType], a
	ret


Text_MinBattlesChoice_BossRushYellow:
	db "BOSS RUSH Y@"
