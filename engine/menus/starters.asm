StarterMenu:
	call ClearMenuExtra
	ld hl, StarterChoicesList
	call MenuCore
	ret


StarterChoicesList:
	menu_choice Determine_StarterChoice_Charmander, Action_StarterChoice_Charmander, Text_StarterChoice_Charmander
	menu_choice Determine_StarterChoice_Bulbasaur,  Action_StarterChoice_Bulbasaur,  Text_StarterChoice_Bulbasaur
	menu_choice Determine_StarterChoice_Squirtle,   Action_StarterChoice_Squirtle,   Text_StarterChoice_Squirtle
	menu_choice Determine_StarterChoice_Pikachu,    Action_StarterChoice_Pikachu,    Text_StarterChoice_Pikachu
	menu_choice Determine_StarterChoice_Eevee,      Action_StarterChoice_Eevee,      Text_StarterChoice_Eevee
	dw MENU_CHOICES_LIST_END


Determine_StarterChoice_Charmander:
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_RED
	call InvertZeroFlag
	ret


Action_StarterChoice_Charmander:
	ld a, STARTER1
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER2
	ld [wRivalStarter], a
	ret


Text_StarterChoice_Charmander:
	db "CHARMANDER@"


Determine_StarterChoice_Bulbasaur:
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_RED
	call InvertZeroFlag
	ret


Action_StarterChoice_Bulbasaur:
	ld a, STARTER2
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER3
	ld [wRivalStarter], a
	ret


Text_StarterChoice_Bulbasaur:
	db "BULBASAUR@"


Determine_StarterChoice_Squirtle:
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_RED
	call InvertZeroFlag
	ret


Action_StarterChoice_Squirtle:
	ld a, STARTER3
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER1
	ld [wRivalStarter], a
	ret


Text_StarterChoice_Squirtle:
	db "SQUIRTLE@"


Determine_StarterChoice_Pikachu:
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_YELLOW
	call InvertZeroFlag
	ret


Action_StarterChoice_Pikachu:
	ld a, STARTER4
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER5
	ld [wRivalStarter], a
	ret


Text_StarterChoice_Pikachu:
	db "PIKACHU@"


Determine_StarterChoice_Eevee:
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_YELLOW
	call InvertZeroFlag
	ret


Action_StarterChoice_Eevee:
	ld a, STARTER5
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER4
	ld [wRivalStarter], a
	ret


Text_StarterChoice_Eevee:
	db "EEVEE@"
