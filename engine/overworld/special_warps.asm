SpecialWarpIn::
	call LoadSpecialWarpData
	predef LoadTilesetHeader
	ld hl, wd732
	bit 2, [hl] ; dungeon warp or fly warp?
	res 2, [hl]
	jr z, .next
; if dungeon warp or fly warp
	ld a, [wDestinationMap]
	jr .next2
.next
	ld a, 0
.next2
	ld b, a
	ld a, [wd72d]
	and a
	jr nz, .next4
	ld a, b
.next4
	ld hl, wd732
	bit 4, [hl] ; dungeon warp?
	ret nz
; if not dungeon warp
	ld [wLastMap], a
	ret

; gets the map ID, tile block map view pointer, tileset, and coordinates
LoadSpecialWarpData:
	ld a, [wd72d]
	cp TRADE_CENTER
	jr nz, .notTradeCenter
	ld hl, TradeCenterSpec1
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK ; which gameboy is clocking determines who is on the left and who is on the right
	jr z, .copyWarpData
	ld hl, TradeCenterSpec2
	jr .copyWarpData
.notTradeCenter
	cp COLOSSEUM
	jr nz, .notColosseum
	ld hl, ColosseumSpec1
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .copyWarpData
	ld hl, ColosseumSpec2
	jr .copyWarpData
.notColosseum
.copyWarpData
	ld de, wCurMap
	ld c, $7
.copyWarpDataLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copyWarpDataLoop
	ld a, [hli]
	ld [wCurMapTileset], a
	xor a
	jr .done
.done
	ld [wYOffsetSinceLastSpecialWarp], a
	ld [wXOffsetSinceLastSpecialWarp], a
	ld a, $ff ; the player's coordinates have already been updated using a special warp, so don't use any of the normal warps
	ld [wDestinationWarpID], a
	ret

INCLUDE "data/maps/special_warps.asm"
