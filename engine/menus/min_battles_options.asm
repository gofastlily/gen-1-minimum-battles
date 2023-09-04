DisplayMinBattlesOptionsMenu::
	call InitMinBattlesOptionsMenu
.MinBattlesOptionsMenuLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and START | B_BUTTON
	jr nz, .exitMinBattlesOptionsMenu
	call MinBattlesOptionsControl
	jr c, .dpadDelay
	call GetMinBattlesOptionsPointer
	jr c, .exitMinBattlesOptionsMenu
.dpadDelay
	call MinBattlesOptionsMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .MinBattlesOptionsMenuLoop
.exitMinBattlesOptionsMenu
	call StartConfirm
	jr c, .MinBattlesOptionsMenuLoop
	ret


GetMinBattlesOptionsPointer:
	ld a, [wOptionsCursorLocation]
	ld e, a
	ld d, $0
	ld hl, MinBattlesOptionsMenuJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl  ; jump to the function for the current highlighted option


MinBattlesOptionsMenuJumpTable:
	dw MinBattlesOptionsMenu_DoNickname
	dw MinBattlesOptionsMenu_DoEvolution
	dw MinBattlesOptionsMenu_Dummy
	dw MinBattlesOptionsMenu_Dummy
	dw MinBattlesOptionsMenu_Dummy
	dw MinBattlesOptionsMenu_Dummy
	dw MinBattlesOptionsMenu_Dummy
	dw MinBattlesOptionsMenu_Start


MinBattlesOptionsMenu_DoNickname:
	ldh a, [hJoy5]
	and D_RIGHT | D_LEFT
	jr nz, .changeOption
	ld a, [wMinBattlesOptions]
	and %10000000  ; mask other bits
	jr .writeOption
.changeOption
	ld a, [wMinBattlesOptions]
	xor %10000000  ; mask other bits
	ld [wMinBattlesOptions], a
.writeOption
	ld bc, $0
	sla a
	rl c
	ld hl, YesNoMinimumBattlesOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 13, 2
	call PlaceString
	and a
	ret


MinBattlesOptionsMenu_DoEvolution:
	ldh a, [hJoy5]
	and D_RIGHT | D_LEFT
	jr nz, .changeOption
	ld a, [wMinBattlesOptions]
	and %01000000  ; mask other bits
	jr .writeOption
.changeOption
	ld a, [wMinBattlesOptions]
	xor %01000000  ; mask other bits
	ld [wMinBattlesOptions], a
.writeOption
	ld bc, $0
	sla a
	sla a
	rl c
	ld hl, YesNoMinimumBattlesOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 13, 4
	call PlaceString
	and a
	ret


MinBattlesOptionsMenu_Dummy:
	and a
	ret


MinBattlesOptionsMenu_Start:
	ldh a, [hJoy5]
	and A_BUTTON
	jr nz, .pressedStart
	and a
	ret
.pressedStart
	ld a, [wMenuExitMethod]
	cp CHOSE_FIRST_ITEM
	jp c, .redisplayMinBattlesOptionsMenu
	scf
	ret
.redisplayMinBattlesOptionsMenu
	call DisplayMinBattlesOptionsMenu
	ret


YesNoMinimumBattlesOptionStringsPointerTable:
	dw MinimumBattlesOptionsYesText
	dw MinimumBattlesOptionsNoText


MinimumBattlesOptionsYesText:
	db "YES@"

MinimumBattlesOptionsNoText:
	db "NO @"


MinBattlesOptionsControl:
	ld hl, wOptionsCursorLocation
	ldh a, [hJoy5]
	cp D_DOWN
	jr z, .pressedDown
	cp D_UP
	jr z, .pressedUp
	and a
	ret
.pressedDown
	ld a, [hl]
	cp $7
	jr nz, .doNotWrapAround
	ld [hl], $0
	scf
	ret
.doNotWrapAround
	cp $1  ; The zero-indexed number of options so the menu skips the blank space
	jr c, .regularIncrement
	ld [hl], $6
.regularIncrement
	inc [hl]
	scf
	ret
.pressedUp
	ld a, [hl]
	cp $7
	jr nz, .doNotMoveCursorToLowestOption
	ld [hl], $1  ; The zero-indexed number of options so the menu skips the blank space
	scf
	ret
.doNotMoveCursorToLowestOption
	and a
	jr nz, .regularDecrement
	ld [hl], $8
.regularDecrement
	dec [hl]
	scf
	ret


MinBattlesOptionsMenu_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, 16
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 2
	ld bc, SCREEN_WIDTH * 2
	ld a, [wOptionsCursorLocation]
	call AddNTimes
	ld [hl], "▶"
	ret


InitMinBattlesOptionsMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	hlcoord 2, 2
	ld de, AllMinimumBattlesOptionsText
	call PlaceString
	hlcoord 2, 16
	ld de, MinBattlesOptionsMenuStartText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 2  ; the number of options to loop through
.loop
	push bc
	call GetMinBattlesOptionsPointer ; updates the next option
	pop bc
	ld hl, wOptionsCursorLocation
	inc [hl]  ; moves the cursor for the highlighted option
	dec c
	jr nz, .loop
	xor a
	ld [wOptionsCursorLocation], a
	inc a
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ret


AllMinimumBattlesOptionsText:
	db   "NICKNAME:"
	next "EVOLUTION:@"


MinBattlesOptionsMenuStartText:
	db "START@"


StartConfirm:
	ld hl, StartGameConfirmText
	call PrintText
	hlcoord 0, 7
	lb bc, 8, 1
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wCurrentMenuItem]
	ret


StartGameConfirmText:
	text_far _StartGameConfirmText
	text_end


_StartGameConfirmText::
	text "Ready to begin?"
	done
