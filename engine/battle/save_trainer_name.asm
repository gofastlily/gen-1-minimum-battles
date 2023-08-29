SaveTrainerName::
	; https://github.com/pret/pokered/wiki/Remove-Redundant-TrainerNamePointers
	ld hl, wTrainerName
	ld de, wcd6d
.CopyCharacter
	ld a, [hli]
	ld [de], a
	inc de
	cp "@"
	jr nz, .CopyCharacter
	ret
