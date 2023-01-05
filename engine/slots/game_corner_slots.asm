StartSlotMachine:
	; inlined check for coins without check for coin case
	ld hl, wPlayerCoins
	ld c, a
	ld a, [hli]
	and a
	jr nz, .playerHasCoins
	ld a, [hl]
	cp c
	jr nc, .playerHasCoins
	ret
.playerHasCoins
	ld a, [wLuckySlotHiddenObjectIndex]
	ld b, a
	ld a, [wHiddenObjectIndex]
	inc a
	cp b
	jr z, .match
	ld a, 253
	jr .next
.match
	ld a, 250
.next
	ld [wSlotMachineSevenAndBarModeChance], a
	ldh a, [hLoadedROMBank]
	ld [wSlotMachineSavedROMBank], a
	call PromptUserToPlaySlots
	ret
