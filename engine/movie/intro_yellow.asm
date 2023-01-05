PlayIntroScene:
	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, $f
	ldh [rIE], a
	ld a, $8
	ldh [rSTAT], a
	vc_hook Stop_Reducing_intro_scene_flashing
	call YellowIntro_BlankPalettes
	xor a
	ldh [hLCDCPointer], a
	call DelayFrame
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	ld a, $90
	ldh [hWY], a
	call ClearObjectAnimationBuffers
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call Bank3E_FillMemory
	call YellowIntro_BlankOAMBuffer
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hAutoBGTransferEnabled], a
	ret

Bank3E_FillMemory:
	push de
	ld e, a
.loop
	ld a, e
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	pop de
	ret

YellowIntro_BlankOAMBuffer:
	ld hl, wShadowOAM
	ld bc, wShadowOAMEnd - wShadowOAM
	xor a
	call Bank3E_FillMemory
	ret

YellowIntro_BlankPalettes:
	xor a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	call UpdateGBCPal_BGP
	call UpdateGBCPal_OBP0
	call UpdateGBCPal_OBP1
	ret
