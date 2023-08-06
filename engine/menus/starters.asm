StarterMenu:
	call ClearMenuExtra
	ld hl, StarterChoicesList
	call MenuCore
	ld a, [wMenuExitMethod]
	cp CANCELLED_MENU
	jp z, StarterMenu
	ret


StarterChoicesList:
	menu_choice Determine_StarterChoice_Charmander, Action_StarterChoice_Charmander, Text_StarterChoice_Charmander
	menu_choice Determine_StarterChoice_Bulbasaur,  Action_StarterChoice_Bulbasaur,  Text_StarterChoice_Bulbasaur
	menu_choice Determine_StarterChoice_Squirtle,   Action_StarterChoice_Squirtle,   Text_StarterChoice_Squirtle
	menu_choice Determine_StarterChoice_Pikachu,    Action_StarterChoice_Pikachu,    Text_StarterChoice_Pikachu
	menu_choice Determine_StarterChoice_Eevee,      Action_StarterChoice_Eevee,      Text_StarterChoice_Eevee
	dw MENU_CHOICES_LIST_END


Determine_StarterChoice_Charmander:
	ld a, [wBeatMinBattles]
	and %11111100
	cp %11111100
	jp z, .invert
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_RED
.invert
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


	nop
Determine_StarterChoice_Bulbasaur:
	ld a, [wBeatMinBattles]
	and %11111100
	cp %11111100
	jp z, .invert
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_RED
.invert
	call InvertZeroFlag
	ret


Action_StarterChoice_Bulbasaur:
	ld a, STARTER3
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER1
	ld [wRivalStarter], a
	ret


Text_StarterChoice_Bulbasaur:
	db "BULBASAUR@"


Determine_StarterChoice_Squirtle:
	ld a, [wBeatMinBattles]
	and %11111100
	cp %11111100
	jp z, .invert
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_RED
.invert
	call InvertZeroFlag
	ret


Action_StarterChoice_Squirtle:
	ld a, STARTER2
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER3
	ld [wRivalStarter], a
	ret


Text_StarterChoice_Squirtle:
	db "SQUIRTLE@"


Determine_StarterChoice_Pikachu:
	ld a, [wBeatMinBattles]
	and %11111100
	cp %11111100
	jp z, .invert
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_YELLOW
.invert
	call InvertZeroFlag
	ret


Action_StarterChoice_Pikachu:
	; Check if the game has been beaten with Eevee, if so, award a Thunderstone
	ld a, [wBeatMinBattles]
	and %00100000
	cp %00100000
	jp nz, .noStone
	lb bc, THUNDER_STONE, 1
	call GiveItemSilent
.noStone
	; Give Pikachu
	ld a, STARTER4
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER5
	ld [wRivalStarter], a
	ret


Text_StarterChoice_Pikachu:
	db "PIKACHU@"


Determine_StarterChoice_Eevee:
	ld a, [wBeatMinBattles]
	and %11111100
	cp %11111100
	jp z, .invert
	ld a, [wMinBattlesGameType]
	cp MIN_BATTLES_YELLOW
.invert
	call InvertZeroFlag
	ret


Action_StarterChoice_Eevee:
	; Give player one of each stone
	lb bc, FIRE_STONE, 1
	call GiveItemSilent
	lb bc, THUNDER_STONE, 1
	call GiveItemSilent
	lb bc, WATER_STONE, 1
	call GiveItemSilent
	; Give Eevee
	ld a, STARTER5
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER4
	ld [wRivalStarter], a
	ret


Text_StarterChoice_Eevee:
	db "EEVEE@"
