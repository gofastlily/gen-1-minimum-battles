FreezeEnemyTrainerSprite::
	ld hl, RivalIDs
	ld a, [wEngagedTrainerClass]
	ld b, a
.loop
	ld a, [hli]
	cp -1
	jr z, .notRival
	cp b
	ret z ; the rival leaves after battling, so don't freeze him
	jr .loop
.notRival
	ld a, [wSpriteIndex]
	ldh [hSpriteIndex], a
	jp SetSpriteMovementBytesToFF

RivalIDs:
	db OPP_RIVAL1
	db OPP_RIVAL2
	db OPP_RIVAL3
	db -1 ; end
