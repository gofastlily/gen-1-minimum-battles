Func_1510::
	push hl
	ld hl, wPikachuOverworldStateFlags
	set 7, [hl]
	ld hl, wSpritePikachuStateData1ImageIndex ; pikachu data?
	ld [hl], $ff
	pop hl
	ret

Func_151d::
	push hl
	ld hl, wPikachuOverworldStateFlags
	res 7, [hl]
	pop hl
	ret

EnablePikachuOverworldSpriteDrawing::
	ret

DisablePikachuOverworldSpriteDrawing::
	ret

DisablePikachuFollowingPlayer::
	ret

EnablePikachuFollowingPlayer::
	ret

CheckPikachuFollowingPlayer::
	ret

SpawnPikachu::
	ret

Pikachu_IsInArray::
	ld b, $0
	ld c, a
.loop
	inc b
	ld a, [hli]
	cp $ff
	jr z, .not_in_array
	cp c
	jr nz, .loop
	dec b
	dec hl
	scf
	ret

.not_in_array
	dec b
	dec hl
	and a
	ret

GetPikachuMovementScriptByte::
	ret

ApplyPikachuMovementData::
	ret
