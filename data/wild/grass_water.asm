WildDataPointers:
	table_width 2, WildDataPointers
	dw NothingWildMons
	dw NothingWildMons
	assert_table_length NUM_MAPS
	dw -1 ; end

; wild pokemon data is divided into two parts.
; first part:  pokemon found in grass
; second part: pokemon found while surfing
; each part goes as follows:
    ; if first byte == 0, then
        ; no wild pokemon on this map
    ; if first byte != 0, then
        ; first byte is encounter rate
        ; followed by 20 bytes:
        ; level, species (ten times)

INCLUDE "data/wild/maps/nothing.asm"
