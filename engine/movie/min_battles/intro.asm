PrepareMinBattles:
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


MinBattlesIntro::
	call StopAllMusic ; stop music
	ld a, BANK(Music_Routes2)
	ld c, a
	ld a, MUSIC_ROUTES2
	call PlayMusic
	call ClearScreen
	call LoadTextBoxTilePatterns
	ld a, [wNumHoFTeams]
	jr nz, .skipDefaultNameAndErase
	call PrepareMinBattles
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
	ld hl, MinBattlesBoyGirlText  ; added to the same file as the other oak text
	call PrintText      ; show this text
	farcall BoyGirlChoice  ; added routine at the end of this file
	ld a, [wCurrentMenuItem]
	ld [wPlayerGender], a  ; store player's gender. 00 for boy, 01 for girl, 02 for enby
	call ClearScreen       ; clear the screen before resuming normal intro
	xor a
	ldh [hTileAnimations], a
	call ClearScreen
	ld de, RedPicFront
	lb bc, BANK(RedPicFront), $00
	ld a, [wPlayerGender]  ; load gender
	and a  ; check gender - and a is equivalent to `cp a, 0` (but faster)
           ; if a=0->gender=male, ergo jump to the vanilla part of the code
	jr z, .ContinueWithOakIntro1
	cp a, 2	 ; check gender: if a=2->gender=enby, jump to the yellow subroutine, otherwise continue below
	jp z, .LoadYellowPicFront1
	ld de, GreenPicFront
	lb bc, BANK(GreenPicFront), $00
	jr .ContinueWithOakIntro1
.LoadYellowPicFront1
	ld de, YellowPicFront
	lb bc, BANK(YellowPicFront), $00
.ContinueWithOakIntro1:
	call MinBattlesIntroDisplayPicCenteredOrUpperRight
	call MinBattlesFadeInIntroPic
	ld hl, MinBattlesIntroducePlayerText
	call PrintText
	farcall ChoosePlayerName
	call ClearScreen
	ld de, Rival1Pic
	lb bc, BANK(Rival1Pic), $00
	call MinBattlesIntroDisplayPicCenteredOrUpperRight
	call MinBattlesFadeInIntroPic
	ld hl, MinBattlesIntroduceRivalText
	call PrintText
	farcall ChooseRivalName
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
	ld a, [wPlayerGender]  ; check gender
	and a  ; check gender -> if male, jump to vanilla code
	jr z, .ContinueWithOakIntro2
	cp a, 2
	jp z, .LoadYellowPicFront2
	ld de, GreenPicFront
	lb bc, BANK(GreenPicFront), $00
	jr .ContinueWithOakIntro2
.LoadYellowPicFront2
	ld de, YellowPicFront
	lb bc, BANK(YellowPicFront), $00
.ContinueWithOakIntro2:
	call MinBattlesIntroDisplayPicCenteredOrUpperRight
	ld hl, ChooseStarterText
	call PrintText
	call MinBattlesIntroSlidePicRight

	callfar StarterMenu

.givePlayerStarter
	ld a, [wPlayerStarter]
	ld b, a
	ld c, 5

IF DEF(_DEBUG)
	; ld a, MEWTWO
	; ld b, a
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


_ChooseStarterText:
	text "Which #MON do"
	line "you want?"
	done


NintenText:
	db "NINTEN@"


SonyText:
	db "SONY@"


MinBattlesIntroducePlayerText:
	text_far _MinBattlesIntroducePlayerText
	text_end


_MinBattlesIntroducePlayerText::
	text "First, what is"
	line "your name?"
	prompt


MinBattlesIntroduceRivalText:
	text_far _MinBattlesIntroduceRivalText
	text_end


_MinBattlesIntroduceRivalText::
	text "...Erm, what is"
	line "his name again?"
	prompt


MinBattlesBoyGirlText:
	text_far _MinBattlesBoyGirlText
	text_end


_MinBattlesBoyGirlText::
	text "Play as a boy or"
	line "as a girl?"
	done


MinBattlesFadeInIntroPic:
	ld hl, MinBattlesIntroFadePalettes
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


MinBattlesIntroFadePalettes:
	db %01010100
	db %10101000
	db %11111100
	db %11111000
	db %11110100
	db %11100100


; DisplayPicCenteredOrUpperRight:
; 	call GetPredefRegisters
MinBattlesIntroDisplayPicCenteredOrUpperRight:
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


MinBattlesIntroSlidePicLeft:
	push de
	hlcoord 0, 0
	lb bc, 12, 11
	call ClearScreenArea ; clear the name list text box
	ld c, 10
	call DelayFrames
	pop de
	ld hl, wcd6d
	ld bc, NAME_LENGTH
	call CopyData
	call Delay3
	hlcoord 12, 4
	lb de, 6, 6 * SCREEN_WIDTH + 5
	ld a, $ff
	jr MinBattlesIntroSlidePicCommon


MinBattlesIntroSlidePicRight:
	hlcoord 5, 4
	lb de, 6, 6 * SCREEN_WIDTH + 5
	xor a


MinBattlesIntroSlidePicCommon:
	push hl
	push de
	push bc
	ldh [hSlideDirection], a
	ld a, d
	ldh [hSlideAmount], a
	ld a, e
	ldh [hSlidingRegionSize], a
	ld c, a
	ldh a, [hSlideDirection]
	and a
	jr nz, .next
; If sliding right, point hl to the end of the pic's tiles.
	ld d, 0
	add hl, de
.next
	ld d, h
	ld e, l
.loop
	xor a
	ldh [hAutoBGTransferEnabled], a
	ldh [hAutoBGTransferPortion], a
	ldh a, [hSlideDirection]
	and a
	jr nz, .slideLeft
; sliding right
	ld a, [hli]
	ld [hld], a
	dec hl
	jr .next2
.slideLeft
	ld a, [hld]
	ld [hli], a
	inc hl
.next2
	dec c
	jr nz, .loop
	ldh a, [hSlideDirection]
	and a
	jr z, .next3
; If sliding left, we need to zero the last tile in the pic (there is no need
; to take a corresponding action when sliding right because hl initially points
; to a 0 tile in that case).
	dec hl
	xor a
	ld [hl], a
.next3
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ldh a, [hSlidingRegionSize]
	ld c, a
	ld h, d
	ld l, e
	ldh a, [hSlideDirection]
	and a
	jr nz, .slideLeft2
	inc hl
	jr .next4
.slideLeft2
	dec hl
.next4
	ld d, h
	ld e, l
	ldh a, [hSlideAmount]
	dec a
	ldh [hSlideAmount], a
	jr nz, .loop
	pop bc
	pop de
	pop hl
	ret


MinBattlesChooseRivalName:
	call MinBattlesIntroSlidePicRight
	ld de, DefaultNamesRival
	farcall DisplayIntroNameTextBox
	ld a, [wCurrentMenuItem]
	and a
	jr z, .customName
	ld hl, DefaultNamesRivalList
	call GetDefaultName
	ld de, wRivalName
	call MinBattlesIntroSlidePicLeft
	jr .done
.customName
	ld hl, wRivalName
	ld a, NAME_RIVAL_SCREEN
	ld [wNamingScreenType], a
	farcall DisplayNamingScreen
	ld a, [wStringBuffer]
	cp "@"
	jr z, .customName
	call ClearScreen
	call Delay3
	ld de, Rival1Pic
	ld b, $13
	call MinBattlesIntroDisplayPicCenteredOrUpperRight
.done
	ld hl, MinBattlesHisNameIsText
	jp PrintText


MinBattlesHisNameIsText:
	text_far _MinBattlesHisNameIsText
	text_end

_MinBattlesHisNameIsText::
	text "That's right! His"
	line "name is <RIVAL>!"
	prompt
