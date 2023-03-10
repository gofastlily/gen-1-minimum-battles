SetDefaultNames:
	ld a, [wLetterPrintingDelayFlags]
	push af
	ld a, [wOptions]
	push af
	ld a, [wd732]
	push af
	ld a, [wPrinterSettings]
	push af
	; wipe player data
	ld hl, wPlayerName
	ld bc, wBoxDataEnd - wPlayerName
	xor a
	call FillMemory
	ld hl, wSpriteDataStart
	ld bc, wSpriteDataEnd - wSpriteDataStart
	xor a
	call FillMemory
	xor a
	ld [wSurfingMinigameHiScore], a
	ld [wSurfingMinigameHiScore + 1], a
	ld [wSurfingMinigameHiScore + 2], a
	; end wipe player data
	pop af
	ld [wPrinterSettings], a
	pop af
	ld [wd732], a
	pop af
	ld [wOptions], a
	pop af
	ld [wLetterPrintingDelayFlags], a
	ld a, [wOptionsInitialized]
	and a
	call z, InitOptions
	ld hl, NintenText
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	call CopyData
	ld hl, SonyText
	ld de, wRivalName
	ld bc, NAME_LENGTH
	call CopyData ; rip optimizations
	ret


OakSpeech:
	call StopAllMusic ; stop music
	ld a, BANK(Music_Routes2)
	ld c, a
	ld a, MUSIC_ROUTES2
	call PlayMusic
	call ClearScreen
	call LoadTextBoxTilePatterns
	ld a, [wNumHoFTeams]
	jr nz, .skipDefaultNameAndErase
	call SetDefaultNames
.skipDefaultNameAndErase
	predef InitPlayerData2
	ld hl, wNumBoxItems
	ld a, POTION
	ld [wcf91], a
	ld a, 1
	ld [wItemQuantity], a
	call AddItemToInventory  ; give one potion
	ld a, [wNumHoFTeams]
	and a
	jr nz, .skipChoosingNames
	xor a
	ldh [hTileAnimations], a
	call ClearScreen
	ld de, RedPicFront
	lb bc, BANK(RedPicFront), $00
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, IntroducePlayerText
	call PrintText
	call ChoosePlayerName
	call ClearScreen
	ld de, Rival1Pic
	lb bc, BANK(Rival1Pic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, IntroduceRivalText
	call PrintText
	call ChooseRivalName
.skipChoosingNames
	call ClearScreen
	call ChooseStarter
	call ClearScreen ; rip more tail-end optimizations
	ret


ChooseStarter:
	; Default to the Starter Pikachu and Rival's Eevee
	ld a, STARTER4
	ld [wPlayerStarter], a
	ld b, a
	ld a, STARTER5
	ld [wRivalStarter], a

	; If the player has not beaten Yellow Version yet, skip starter selection
	ld a, [wBeatMinBattles]
	bit 7, a
	jp z, .givePlayerStarter

	ld de, RedPicFront
	lb bc, BANK(RedPicFront), $00
	call IntroDisplayPicCenteredOrUpperRight
	ld hl, ChooseStarterText
	call PrintText
	call OakSpeechSlidePicRight

	call StarterMenu

.givePlayerStarter
	ld c, 5

IF DEF(_DEBUG)
	ld a, MEWTWO
	ld b, a
	ld c, 100
ENDC

	call GivePokemon

IF DEF(_DEBUG)
	ld hl, wPartyMon1Moves
	ld a, PSYCHIC_M
	ld [hli], a
	ld a, THUNDERBOLT
	ld [hli], a
	ld a, ICE_BEAM
	ld [hli], a
	ld a, RECOVER
	ld [hl], a
ENDC

	call ClearScreen
	ret


ChooseStarterText:
	text_far _ChooseStarterText
	text_end


_ChooseStarterText::
	text "Which #MON do"
	line "you want?"
	done


IntroducePlayerText:
	text_far _IntroducePlayerText
	text_end


IntroduceRivalText:
	text_far _IntroduceRivalText
	text_end


FadeInIntroPic:
	ld hl, IntroFadePalettes
	ld b, 6
.next
	ld a, [hli]
	ldh [rBGP], a
	call UpdateGBCPal_BGP
	ld c, 10
	call DelayFrames
	dec b
	jr nz, .next
	ret

IntroFadePalettes:
	db %01010100
	db %10101000
	db %11111100
	db %11111000
	db %11110100
	db %11100100


DisplayPicCenteredOrUpperRight:
	call GetPredefRegisters
IntroDisplayPicCenteredOrUpperRight:
; b = bank
; de = address of compressed pic
; c: 0 = centred, non-zero = upper-right
	push bc
	ld a, b
	call UncompressSpriteFromDE
	ld a, $0
	call SwitchSRAMBankAndLatchClockData
	ld hl, sSpriteBuffer1
	ld de, sSpriteBuffer0
	ld bc, $310
	call CopyData
	call PrepareRTCDataAndDisableSRAM
	ld de, vFrontPic
	call InterlaceMergeSpriteBuffers
	pop bc
	ld a, c
	and a
	hlcoord 15, 1
	jr nz, .next
	hlcoord 6, 4
.next
	xor a
	ldh [hStartTileID], a
	predef_jump CopyUncompressedPicToTilemap
