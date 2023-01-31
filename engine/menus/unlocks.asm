UnlocksMenu:
	call ClearMenuExtra
	ld hl, UnlocksChoicesList
	call MenuCore
	ret


UnlocksChoicesList:
	menu_choice Determine_UnlocksChoice_RedBlue,           Action_UnlocksChoice_RedBlue,           Text_UnlocksChoice_RedBlue
	menu_choice Determine_UnlocksChoice_EeveeLocked,       Action_UnlocksChoice_EeveeLocked,       Text_UnlocksChoice_EeveeLocked
	menu_choice Determine_UnlocksChoice_Eevee,             Action_UnlocksChoice_Eevee,             Text_UnlocksChoice_Eevee
	menu_choice Determine_UnlocksChoice_MixStartersLocked, Action_UnlocksChoice_MixStartersLocked, Text_UnlocksChoice_MixStartersLocked
	menu_choice Determine_UnlocksChoice_MixStarters,       Action_UnlocksChoice_MixStarters,       Text_UnlocksChoice_MixStarters
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
	xor %11111100
	and %11111100
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
	xor %11111100
	and %11111100
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
