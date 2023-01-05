; Loads tile patterns for map's sprites.
; For outside maps, it loads one of several fixed sets of sprites.
; For inside maps, it loads each sprite picture ID used in the map header.
; This is also called after displaying text because loading
; text tile patterns overwrites half of the sprite tile pattern data.
; Note on notation:
; x#SPRITESTATEDATA1_* and x#SPRITESTATEDATA2_* are used to denote wSpriteStateData1 and
; wSpriteStateData2 sprite slot, respectively, within loops. The X is the loop index.
; If there is an inner loop, Y is the inner loop index, i.e. y#SPRITESTATEDATA1_* and
; y#SPRITESTATEDATA2_* denote fields of the sprite slots iterated over in the inner loop.
_InitMapSprites::
	call LoadSpriteSetFromMapHeader
	call LoadMapSpriteTilePatterns
	call Func_14150
	ret

LoadSpriteSetFromMapHeader:
; This loop stores the correct VRAM tile pattern slots according the sprite
; data from the map's header. Since the VRAM tile pattern slots are filled in
; the order of the sprite set, in order to find the VRAM tile pattern slot
; for a sprite slot, the picture ID for the sprite is looked up within the
; sprite set. The index of the picture ID within the sprite set plus two
; (since the Red sprite always has the first VRAM tile pattern slot and the
; Pikachu sprite reserves the second slot) is the VRAM tile pattern slot.
	ld hl, wSpriteSet
	ld bc, (wSpriteSetID - wSpriteSet)
	xor a
	call FillMemory
	ld a, SPRITE_PIKACHU ; load Pikachu separately
	ld [wSpriteSet], a
	ld hl, wSprite01StateData1
	ld a, 14
.storeVRAMSlotsLoop
	push af
	ld a, [hl] ; [x#SPRITESTATEDATA1_PICTUREID] (zero if sprite slot is not used)
	and a ; is the sprite slot used?
	jr z, .continue ; if the sprite slot is not used
	ld c, a
	call CheckForFourTileSprite ; is this a four tile sprite?
	jr nc, .isFourTileSprite
; loop through the space reserved for four tile picture IDs
	ld de, wSpriteSet + 9
	ld b, 2
	call CheckIfPictureIDAlreadyLoaded
	jr .continue

.isFourTileSprite
; loop through the space reserved for regular picture IDs
	ld de, wSpriteSet
	ld b, 9
	call CheckIfPictureIDAlreadyLoaded
.continue
	ld de, wSprite02StateData1 - wSprite01StateData1
	add hl, de
	pop af
	dec a
	jr nz, .storeVRAMSlotsLoop
	ret

CheckIfPictureIDAlreadyLoaded:
; Check if the current picture ID has already had its tile patterns loaded.
; This done by looping through the previous sprite slots and seeing if any of
; their picture ID's match that of the current sprite slot.
.loop
	ld a, [de]
	and a ; is sprite set slot not taken up yet?
	jr z, .spriteSlotNotTaken ; if so, load it as it signifies we've reached
	                          ; the end of data for the last sprite set

	cp c  ; is the tile pattern already loaded?
	ret z ; don't redundantly load
	dec b ; have we reached the end of the sprite set?
	jr z, .spriteNotAlreadyLoaded ; if so, we're done here
	inc de
	jr .loop

.spriteSlotNotTaken
	ld a, c
	ld [de], a
	ret
.spriteNotAlreadyLoaded
	scf
	ret

CheckForFourTileSprite:
; Checks for a sprite added in yellow
; Returns no carry if the sprite is Pikachu, as its sprite is handled separately
; Else, returns carry if the sprite uses 4 tiles
	cp SPRITE_PIKACHU       ; is this the Pikachu Sprite?
	ret z                   ; return if yes

	cp FIRST_STILL_SPRITE   ; is this a four tile sprite?
	jr nc, .notYellowSprite ; set carry if yes
; regular sprite
	and a
	ret

.notYellowSprite
	scf
	ret

LoadMapSpriteTilePatterns:
	ld a, 0
.loop
	ldh [hVRAMSlot], a
	cp 9
	jr nc, .fourTileSprite
	call LoadStillTilePattern
	call LoadWalkingTilePattern
	jr .continue

.fourTileSprite
	call LoadStillTilePattern
.continue
	ldh a, [hVRAMSlot]
	inc a
	cp 11
	jr nz, .loop
	ret

ReloadWalkingTilePatterns:
	xor a
.loop
	ldh [hVRAMSlot], a
	cp 9
	jr nc, .fourTileSprite
	call LoadWalkingTilePattern
.fourTileSprite
	ldh a, [hVRAMSlot]
	inc a
	cp 11
	jr nz, .loop
	ret

LoadStillTilePattern:
	ld a, [wFontLoaded]
	bit 0, a ; reloading upper half of tile patterns after displaying text?
	ret nz ; if so, skip loading data into the lower half
	call ReadSpriteSheetData
	ret nc
	call GetSpriteVRAMAddress
	call CopyVideoDataAlternate ; new yellow function
	ret

LoadWalkingTilePattern:
	call ReadSpriteSheetData
	ret nc
	ld hl, $c0
	add hl, de
	ld d, h
	ld e, l
	call GetSpriteVRAMAddress
	set 3, h ; add $80 tiles to hl
	call CopyVideoDataAlternate
	ret

GetSpriteVRAMAddress:
	push bc
	ldh a, [hVRAMSlot]
	ld c, a
	ld b, 0
	ld hl, SpriteVRAMAddresses
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	ret

SpriteVRAMAddresses:
	dw vChars0 + (1 * 12) tiles
	dw vChars0 + (2 * 12) tiles
	dw vChars0 + (3 * 12) tiles
	dw vChars0 + (4 * 12) tiles
	dw vChars0 + (5 * 12) tiles
	dw vChars0 + (6 * 12) tiles
	dw vChars0 + (7 * 12) tiles
	dw vChars0 + (8 * 12) tiles
	dw vChars0 + (9 * 12) tiles
	dw vChars0 + (10 * 12) tiles ; 4-tile sprites
	dw vChars0 + (10 * 12 + 4) tiles ; 4-tile sprites

ReadSpriteSheetData:
	ldh a, [hVRAMSlot]
	ld e, a
	ld d, 0
	ld hl, wSpriteSet
	add hl, de
	ld a, [hl]
	and a
	ret z

	dec a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, SpriteSheetPointerTable
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld c, [hl]
	swap c ; get the number of tiles, not the raw byte length
		   ; this is because of the use of CopyVideoDataAlternate
	inc hl
	ld b, [hl]
	inc hl
	scf
	ret

Func_14150:
	ld a, $1
	ld [wSpritePlayerStateData2ImageBaseOffset], a ; vram slot for player
	ld a, $2
	ld [wSpritePikachuStateData2ImageBaseOffset], a ; vram slot for Pikachu
	ld a, $e
	ld hl, wSprite01StateData1
.loop
	ldh [hVRAMSlot], a ; store current sprite set slot as a counter
	ld a, [hl] ; [x#SPRITESTATEDATA1_PICTUREID]
	and a ; is the sprite unused?
	jr z, .spriteUnused
	call Func_14179
	push hl
	ld de, wSpritePlayerStateData2ImageBaseOffset - wSpriteStateData1
	add hl, de ; [x#SPRITESTATEDATA2_IMAGEBASEOFFSET]
	ld [hl], a ; write offset
	pop hl
.spriteUnused
	ld de, wSprite02StateData1 - wSprite01StateData1
	add hl, de
	ldh a, [hVRAMSlot]
	dec a
	jr nz, .loop
	ret

Func_14179:
	push de
	push bc
	ld c, a  ; c = picture ID
	ld b, 11
	ld de, wSpriteSet
.findSpriteImageBaseOffsetLoop
	ld a, [de] ; a = sprite set picture ID
	cp c ; have we found a match?
	jr z, .foundSpritePictureID ; if so, get the sprite image base offset and return
	inc de
	dec b ; have we looped through all entries in wSpriteSet?
	jr nz, .findSpriteImageBaseOffsetLoop ; continue looping if not
	ld a, $1 ; assume slot one if this ever happens
	jr .done
.foundSpritePictureID
	ld a, 13
	sub b ; get sprite image base offset
.done
	pop bc
	pop de
	ret

INCLUDE "data/sprites/sprites.asm"
