MACRO fly_warp
	event_displacement \1_WIDTH, \2, \3
	db ((\3) & $01) ;sub-block Y
	db ((\2) & $01) ;sub-block X
ENDM

MACRO special_warp_spec
	db \1
	fly_warp \1, \2, \3
	db \4
ENDM

TradeCenterSpec1:
	special_warp_spec TRADE_CENTER,  3, 4, CLUB
TradeCenterSpec2:
	special_warp_spec TRADE_CENTER,  6, 4, CLUB
ColosseumSpec1:
	special_warp_spec COLOSSEUM,     3, 4, CLUB
ColosseumSpec2:
	special_warp_spec COLOSSEUM,     6, 4, CLUB
