INCLUDE "data/pokemon/dex_entries.asm"

PokedexToIndex:
	; converts the Pokédex number at wd11e to an index
	push bc
	push hl
	ld a, [wd11e]
	ld b, a
	ld c, 0
	ld hl, PokedexOrder

.loop ; go through the list until we find an entry with a matching dex number
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop

	ld a, c
	ld [wd11e], a
	pop hl
	pop bc
	ret

IndexToPokedex:
	; converts the index number at wd11e to a Pokédex number
	push bc
	push hl
	ld a, [wd11e]
	dec a
	ld hl, PokedexOrder
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	pop hl
	pop bc
	ret

INCLUDE "data/pokemon/dex_order.asm"
