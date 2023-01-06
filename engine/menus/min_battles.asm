MinBattlesMenu:
	ld hl, MinBattlesChoicesList
	call MenuCore
	ret


MinBattlesChoicesList:
	menu_choice Determine_MinBattlesChoice_RedBlue, Action_MinBattlesChoice_RedBlue, Text_MinBattlesChoice_RedBlue
	menu_choice Determine_MinBattlesChoice_Yellow,  Action_MinBattlesChoice_Yellow,  Text_MinBattlesChoice_Yellow
	dw MENU_CHOICES_LIST_END


Determine_MinBattlesChoice_RedBlue:
	xor a
	cp 1
	ret


Determine_MinBattlesChoice_Yellow:
	xor a
	cp 1
	ret


Action_MinBattlesChoice_RedBlue:
	ld a, MIN_BATTLES_RED
	ld [wMinBattlesGameType], a
	ret


Action_MinBattlesChoice_Yellow:
	ld a, MIN_BATTLES_YELLOW
	ld [wMinBattlesGameType], a
	ret


Text_MinBattlesChoice_RedBlue:
	db "RED/BLUE@"


Text_MinBattlesChoice_Yellow:
	db "YELLOW@"
