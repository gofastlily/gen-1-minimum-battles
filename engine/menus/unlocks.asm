UnlocksMenu:
	call ClearMenuExtra
	ld hl, UnlocksChoicesList
	call MenuCore
	ret


UnlocksChoicesList:
	menu_choice Determine_UnlocksChoice_RedBlue,               Action_UnlocksChoice_RedBlue,               Text_UnlocksChoice_RedBlue
	menu_choice Determine_UnlocksChoice_EeveeLocked,           Action_UnlocksChoice_EeveeLocked,           Text_UnlocksChoice_EeveeLocked
	menu_choice Determine_UnlocksChoice_Eevee,                 Action_UnlocksChoice_Eevee,                 Text_UnlocksChoice_Eevee
	menu_choice Determine_UnlocksChoice_MixStartersLocked,     Action_UnlocksChoice_MixStartersLocked,     Text_UnlocksChoice_MixStartersLocked
	menu_choice Determine_UnlocksChoice_MixStarters,           Action_UnlocksChoice_MixStarters,           Text_UnlocksChoice_MixStarters
	menu_choice Determine_UnlocksChoice_ThunderstoneLocked,    Action_UnlocksChoice_ThunderstoneLocked,    Text_UnlocksChoice_ThunderstoneLocked
	menu_choice Determine_UnlocksChoice_Thunderstone,          Action_UnlocksChoice_Thunderstone,          Text_UnlocksChoice_Thunderstone
	menu_choice Determine_UnlocksChoice_GymRushLocked,         Action_UnlocksChoice_GymRushLocked,         Text_UnlocksChoice_GymRushLocked
	menu_choice Determine_UnlocksChoice_GymRush,               Action_UnlocksChoice_GymRush,               Text_UnlocksChoice_GymRush
	; menu_choice Determine_UnlocksChoice_BossRushLocked,        Action_UnlocksChoice_BossRushLocked,        Text_UnlocksChoice_BossRushLocked
	; menu_choice Determine_UnlocksChoice_BossRush,              Action_UnlocksChoice_BossRush,              Text_UnlocksChoice_BossRush
	menu_choice Determine_UnlocksChoice_SurfingMinigameLocked, Action_UnlocksChoice_SurfingMinigameLocked, Text_UnlocksChoice_SurfingMinigameLocked
	menu_choice Determine_UnlocksChoice_SurfingMinigame,       Action_UnlocksChoice_SurfingMinigame,       Text_UnlocksChoice_SurfingMinigame
	dw MENU_CHOICES_LIST_END


Determine_UnlocksChoice_RedBlue:
	ld a, [wBeatMinBattles]
	bit 7, a
	ret


Action_UnlocksChoice_RedBlue:
	ld hl, UnlocksTextRedBlue
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_RedBlue:
	db "RED/BLUE@"


UnlocksTextRedBlue:
	text_far _UnlocksTextRedBlue
	text_end


Determine_UnlocksChoice_EeveeLocked:
	ld a, [wBeatMinBattles]
	bit 6, a
	call InvertZeroFlag
	ret


Action_UnlocksChoice_EeveeLocked:
	ld hl, UnlocksTextEeveeLocked
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_EeveeLocked:
	db "?????@"


UnlocksTextEeveeLocked:
	text_far _UnlocksTextEeveeLocked
	text_end


Determine_UnlocksChoice_Eevee:
	ld a, [wBeatMinBattles]
	bit 6, a
	ret


Action_UnlocksChoice_Eevee:
	ld hl, UnlocksTextEevee
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_Eevee:
	db "EEVEE@"


UnlocksTextEevee:
	text_far _UnlocksTextEevee
	text_end


Determine_UnlocksChoice_MixStartersLocked:
	ld a, [wBeatMinBattles]
	and %11111100
	cp %11111100
	ret


Action_UnlocksChoice_MixStartersLocked:
	ld hl, UnlocksTextMixStartersLocked
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_MixStartersLocked:
	db "??? ????????@"


UnlocksTextMixStartersLocked:
	text_far _UnlocksTextMixStartersLocked
	text_end


Determine_UnlocksChoice_MixStarters:
	ld a, [wBeatMinBattles]
	and %11111100
	cp %11111100
	call InvertZeroFlag
	ret


Action_UnlocksChoice_MixStarters:
	ld hl, UnlocksTextMixStarters
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_MixStarters:
	db "MIX STARTERS@"


UnlocksTextMixStarters:
	text_far _UnlocksTextMixStarters
	text_end


Determine_UnlocksChoice_ThunderstoneLocked:
	ld a, [wBeatMinBattles]
	bit 5, a
	call InvertZeroFlag
	ret


Action_UnlocksChoice_ThunderstoneLocked:
	ld hl, UnlocksTextThunderstoneLocked
	ld a, [wBeatMinBattles]
	bit 6, a
	jp z, .printThunderstoneLockedText
	ld hl, UnlocksTextThunderstoneLockedSpoiled
.printThunderstoneLockedText
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_ThunderstoneLocked:
	db "????????????@"


UnlocksTextThunderstoneLocked:
	text_far _UnlocksTextThunderstoneLocked
	text_end


UnlocksTextThunderstoneLockedSpoiled:
	text_far _UnlocksTextThunderstoneLockedSpoiled
	text_end


Determine_UnlocksChoice_Thunderstone:
	ld a, [wBeatMinBattles]
	bit 5, a
	ret


Action_UnlocksChoice_Thunderstone:
	ld hl, UnlocksTextThunderstone
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_Thunderstone:
	db "THUNDERSTONE@"


UnlocksTextThunderstone:
	text_far _UnlocksTextThunderstone
	text_end


Determine_UnlocksChoice_GymRushLocked:
	ld a, [wBeatMinBattlesTwo]
	and %11000000
	cp %11000000
	ret


Action_UnlocksChoice_GymRushLocked:
	ld hl, UnlocksTextGymRushLocked
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_GymRushLocked:
	db "??? ????@"


UnlocksTextGymRushLocked:
	text_far _UnlocksTextGymRushLocked
	text_end


Determine_UnlocksChoice_GymRush:
	ld a, [wBeatMinBattlesTwo]
	and %11000000
	cp %11000000
	call InvertZeroFlag
	ret


Action_UnlocksChoice_GymRush:
	ld hl, UnlocksTextGymRush
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_GymRush:
	db "GYM RUSH@"


UnlocksTextGymRush:
	text_far _UnlocksTextGymRush
	text_end


Determine_UnlocksChoice_BossRushLocked:
	ld a, [wBeatMinBattlesTwo]
	and %11110000
	cp %11110000
	ret


Action_UnlocksChoice_BossRushLocked:
	ld hl, UnlocksTextBossRushLocked
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_BossRushLocked:
	db "???? ????@"


UnlocksTextBossRushLocked:
	text_far _UnlocksTextBossRushLocked
	text_end


Determine_UnlocksChoice_BossRush:
	ld a, [wBeatMinBattlesTwo]
	and %11110000
	cp %11110000
	call InvertZeroFlag
	ret


Action_UnlocksChoice_BossRush:
	ld hl, UnlocksTextBossRush
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_BossRush:
	db "BOSS RUSH@"


UnlocksTextBossRush:
	text_far _UnlocksTextBossRush
	text_end


Determine_UnlocksChoice_SurfingMinigameLocked:
	ld a, [wBeatMinBattlesTwo]
	and %00000001
	cp %00000001
	ret


Action_UnlocksChoice_SurfingMinigameLocked:
	ld hl, UnlocksTextSurfingMinigameLocked
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_SurfingMinigameLocked:
	db "???????@"


UnlocksTextSurfingMinigameLocked:
	text_far _UnlocksTextSurfingMinigameLocked
	text_end


Determine_UnlocksChoice_SurfingMinigame:
	ld a, [wBeatMinBattlesTwo]
	and %00000001
	cp %00000001
	call InvertZeroFlag
	ret


Action_UnlocksChoice_SurfingMinigame:
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	farcall SurfingPikachuMinigame
	ret


Text_UnlocksChoice_SurfingMinigame:
	db "SURFING@"

