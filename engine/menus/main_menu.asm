MainMenu:
	call InitOptions
	; Check save file
	; Needs to be fixed
	xor a
	ld [wOptionsInitialized], a
	inc a
	ld [wSaveFileStatus], a
	call CheckForPlayerNameInSRAM
	jr nc, .loadSkip
	predef LoadSAV

.loadSkip
	ld c, 1
	call DelayFrames
	xor a ; LINK_STATE_NONE
	ld [wLinkState], a
	ld hl, wPartyAndBillsPCSavedMenuItem
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wDefaultMap], a

.menuLoop
	ld hl, MainMenuChoicesList
	call MenuCore
	jp .menuLoop


MainMenuChoicesList:
	menu_choice Determine_MainMenuChoice_Continue, Action_MainMenuChoices_Continue, Text_MainMenuChoices_Continue
	menu_choice Determine_MainMenuChoice_NewGame,  Action_MainMenuChoices_NewGame,  Text_MainMenuChoices_NewGame
	menu_choice Determine_MainMenuChoice_Options,  Action_MainMenuChoices_Options,  Text_MainMenuChoices_Options
	dw MENU_CHOICES_LIST_END


	nop
Determine_MainMenuChoice_Continue:
	; Change to displaying Continue only when the player is mid-run
	ld a, [wSaveFileStatus]
	cp 1
	ret


Determine_MainMenuChoice_NewGame:
	xor a
	cp 1
	ret


Determine_MainMenuChoice_Options:
	xor a
	cp 1
	ret


Action_MainMenuChoices_Continue:
	; Needs to be refactored
	call DisplayContinueGameInfo
	ld a, [wMenuExitMethod]
	cp CANCELLED_MENU
	ret z

	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	ld c, 10
	call DelayFrames

	jp SpecialEnterMap


Action_MainMenuChoices_NewGame:
	callfar StartNewGame
	ret


Action_MainMenuChoices_Options:
	callfar DisplayOptionMenu
	ld a, 1
	ld [wOptionsInitialized], a
	ret


Text_MainMenuChoices_Continue:
	db "CONTINUE@"


Text_MainMenuChoices_NewGame:
	db "NEW GAME@"


Text_MainMenuChoices_Options:
	db "OPTIONS@"


InitOptions:
	ld a, 1 ; no delay
	ld [wLetterPrintingDelayFlags], a
	ld a, %11000001  ; animations off, set battle style, fast speed
	ld [wOptions], a
	ld a, 64
	ld [wPrinterSettings], a
	ret

Func_5cc1:
; unused?
	ld a, $6d
	cp $80
	ret c ; will always be executed
	ld hl, NotEnoughMemoryText
	call PrintText
	ret

NotEnoughMemoryText:
	text_far _NotEnoughMemoryText
	text_end

StartNewGame:
	ld hl, wd732
	res 1, [hl]
StartNewGameDebug:
	call OakSpeech
	ld a, $8
	ld [wPlayerMovingDirection], a
	ld c, 20
	call DelayFrames

	; Add Starter Pikachu to the player's team
	xor a
	ld [wMonDataLocation], a
	ld a, 5
	ld [wCurEnemyLVL], a
	ld a, STARTER_PIKACHU
	ld [wd11e], a
	ld [wcf91], a
	call AddPartyMon
	ld a, LIGHT_BALL_GSC
	ld [wPartyMon1CatchRate], a

	call ClearScreen
	ld hl, wd732
	set 0, [hl]  ; Start the game clock

	; Face Rival 1
.faceOpponent
	predef HealParty
	ld a, OPP_RIVAL1
	ld [wCurOpponent], a
	ld a, $1
	ld [wTrainerNo], a
	call NewBattle

	; if the battle was a loss, try again
	ld a, [wBattleResult]
	cp a, $00
	jr nz, .faceOpponent

	; Load into the Hall of Fame
	predef HallOfFamePC
	ld b, 5
.delayLoop
	ld c, 600 / 5
	call DelayFrames
	dec b
	jr nz, .delayLoop
	call WaitForTextScrollButtonPress

	; Reset
	jp SoftReset

; enter map after using a special warp or loading the game from the main menu
SpecialEnterMap::
	xor a
	ldh [hJoyPressed], a
	ldh [hJoyHeld], a
	ldh [hJoy5], a
	ld [wd72d], a
	ld hl, wd732
	set 0, [hl] ; count play time
	call ResetPlayerSpriteData
	ld c, 20
	call DelayFrames
	call Func_5cc1
	ld a, [wEnteringCableClub]
	and a
	ret nz
	jp EnterMap

ContinueText:
	db "CONTINUE"
	next ""
	; fallthrough

NewGameText:
	db   "NEW GAME"
	next "OPTION@"

DisplayContinueGameInfo:
	xor a
	ldh [hAutoBGTransferEnabled], a
	hlcoord 4, 7
	lb bc, 8, 14
	call TextBoxBorder
	hlcoord 5, 9
	ld de, SaveScreenInfoText
	call PlaceString
	hlcoord 12, 9
	ld de, wPlayerName
	call PlaceString
	hlcoord 17, 11
	call PrintNumBadges
	hlcoord 16, 13
	call PrintNumOwnedMons
	hlcoord 13, 15
	call PrintPlayTime
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	ld c, 30
	jp DelayFrames

PrintSaveScreenText:
	xor a
	ldh [hAutoBGTransferEnabled], a
	hlcoord 4, 0
	lb bc, 8, 14
	call TextBoxBorder
	call LoadTextBoxTilePatterns
	call UpdateSprites
	hlcoord 5, 2
	ld de, SaveScreenInfoText
	call PlaceString
	hlcoord 12, 2
	ld de, wPlayerName
	call PlaceString
	hlcoord 17, 4
	call PrintNumBadges
	hlcoord 16, 6
	call PrintNumOwnedMons
	hlcoord 13, 8
	call PrintPlayTime
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	ld c, 30
	jp DelayFrames

PrintNumBadges:
	push hl
	ld hl, wObtainedBadges
	ld b, $1
	call CountSetBits
	pop hl
	ld de, wNumSetBits
	lb bc, 1, 2
	jp PrintNumber

PrintNumOwnedMons:
	push hl
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	pop hl
	ld de, wNumSetBits
	lb bc, 1, 3
	jp PrintNumber

PrintPlayTime:
	ld de, wPlayTimeHours
	lb bc, 1, 3
	call PrintNumber
	ld [hl], $6d
	inc hl
	ld de, wPlayTimeMinutes
	lb bc, LEADING_ZEROES | 1, 2
	jp PrintNumber

SaveScreenInfoText:
	db   "PLAYER"
	next "BADGES    "
	next "#DEX    "
	next "TIME@"

DisplayOptionMenu:
	callfar DisplayOptionMenu_
	ret

CheckForPlayerNameInSRAM:
; Check if the player name data in SRAM has a string terminator character
; (indicating that a name may have been saved there) and return whether it does
; in carry.
	ld a, SRAM_ENABLE
	ld [MBC1SRamEnable], a
	ld a, $1
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamBank], a
	ld b, NAME_LENGTH
	ld hl, sPlayerName
.loop
	ld a, [hli]
	cp "@"
	jr z, .found
	dec b
	jr nz, .loop
; not found
	xor a
	ld [MBC1SRamEnable], a
	ld [MBC1SRamBankingMode], a
	and a
	ret
.found
	xor a
	ld [MBC1SRamEnable], a
	ld [MBC1SRamBankingMode], a
	scf
	ret
