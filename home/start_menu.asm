DisplayStartMenu::
	ld a, BANK(StartMenu_Continue) ; also bank for other functions
	call BankswitchCommon
	ld a, [wWalkBikeSurfState] ; walking/biking/surfing
	ld [wWalkBikeSurfStateCopy], a
	ld a, SFX_START_MENU
	call PlaySound
	; Minor pause before opening the menu
	ld c, 15
	call DelayFrames

RedisplayStartMenu::
	farcall DrawStartMenu
RedisplayStartMenu_DoNotDrawStartMenu::
	farcall PrintMinBattlesStatus  ; print Safari Zone info, if in Safari Zone
	call UpdateSprites
.loop
	call HandleMenuInput
	ld b, a
.checkIfUpPressed
	bit BIT_D_UP, a
	jr z, .checkIfDownPressed
	ld a, [wCurrentMenuItem] ; menu selection
	and a
	jr nz, .loop
	ld a, [wLastMenuItem]
	and a
	jr nz, .loop
; if the player pressed tried to go past the top item, wrap around to the bottom
	ld a, 6 ; there are 7 menu items with the pokedex, so the max index is 6
	ld [wCurrentMenuItem], a
	call EraseMenuCursor
	jr .loop
.checkIfDownPressed
	bit BIT_D_DOWN, a
	jr z, .buttonPressed
; if the player pressed tried to go past the bottom item, wrap around to the top
	ld a, [wCurrentMenuItem]
	ld c, 7 ; there are 7 menu items with the pokedex
	cp c
	jr nz, .loop
; the player went past the bottom, so wrap to the top
	xor a
	ld [wCurrentMenuItem], a
	call EraseMenuCursor
	jr .loop
.buttonPressed ; A, B, or Start button pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	ld [wBattleAndStartSavedMenuItem], a ; save current menu selection
	ld a, b
	and B_BUTTON | START ; was the Start button or B button pressed?
	jp nz, CloseStartMenu
	call SaveScreenTilesToBuffer2 ; copy background from wTileMap to wTileMapBackup2
	ld a, [wCurrentMenuItem]
.displayMenuItem
	cp 0
	jp z, StartMenu_Continue
	cp 1
	jp z, StartMenu_Pokemon
	cp 2
	jp z, StartMenu_Item
	cp 3
	jp z, StartMenu_TrainerInfo
	cp 4
	jp z, StartMenu_SaveReset
	cp 5
	jp z, StartMenu_Option


; QUIT falls through to here
CloseStartMenu::
	ld hl, QuitGameConfirmText
	call QuitConfirm
	and a
	jp nz, .redisplayStartMenu
	call Init
.redisplayStartMenu
	call ClearScreen
	jp RedisplayStartMenu


QuitConfirm:
	call PrintText
	hlcoord 0, 7
	lb bc, 8, 1
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wCurrentMenuItem]
	ret


QuitGameConfirmText:
	text_far _QuitGameConfirmText
	text_end


_QuitGameConfirmText::
	text "Return to the"
	line "title screen?"
	done
