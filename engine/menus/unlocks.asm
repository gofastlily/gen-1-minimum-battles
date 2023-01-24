UnlocksMenu:
	call ClearMenuExtra
	ld hl, UnlocksChoicesList
	call MenuCore
	ret


UnlocksChoicesList:
	menu_choice Determine_UnlocksChoice_RedBlue,     Action_UnlocksChoice_RedBlue,     Text_UnlocksChoice_RedBlue
	menu_choice Determine_UnlocksChoice_EeveeLocked, Action_UnlocksChoice_EeveeLocked, Text_UnlocksChoice_EeveeLocked
	menu_choice Determine_UnlocksChoice_Eevee,       Action_UnlocksChoice_Eevee,       Text_UnlocksChoice_Eevee
	dw MENU_CHOICES_LIST_END


Determine_UnlocksChoice_RedBlue:
	ld a, [wBeatMinBattles]
	bit 7, a
	ret


Determine_UnlocksChoice_EeveeLocked:
	ld a, [wBeatMinBattles]
	bit 6, a
	; Invert the check
	jr z, .zero
.notZero
    ld a, 0
    jr .done
.zero
    ld a, 1
.done
	and a
	; end invert check
	ret


Determine_UnlocksChoice_Eevee:
	ld a, [wBeatMinBattles]
	bit 6, a
	ret


Action_UnlocksChoice_RedBlue:
	ld hl, UnlocksTextRedBlue
	call PrintText
	jp UnlocksMenu
	ret


Action_UnlocksChoice_EeveeLocked:
	ld hl, UnlocksTextEeveeLocked
	call PrintText
	jp UnlocksMenu
	ret


Action_UnlocksChoice_Eevee:
	ld hl, UnlocksTextEevee
	call PrintText
	jp UnlocksMenu
	ret


Text_UnlocksChoice_RedBlue:
	db "RED/BLUE@"


Text_UnlocksChoice_EeveeLocked:
	db "?????@"


Text_UnlocksChoice_Eevee:
	db "EEVEE@"


UnlocksTextRedBlue:
	text_far _UnlocksTextRedBlue
	text_end


UnlocksTextEeveeLocked:
	text_far _UnlocksTextEeveeLocked
	text_end


UnlocksTextEevee:
	text_far _UnlocksTextEevee
	text_end
