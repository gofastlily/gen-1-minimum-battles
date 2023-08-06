StartMinimumBattles:
	xor a
	ld [wPlayerMinBattlesProgress], a
	ld [wPlayerMinBattlesLosses], a
	ld [wMinBattlesRareCandyUseCount], a
	set 7, a
	ld [wMinBattlesTemp], a

	; Give player 95 rare candies
	lb bc, RARE_CANDY, 95
	call GiveItemSilent
	; Fall through to ContinueMinimumBattles


ContinueMinimumBattles:
	ld hl, wd72e
	res 4, [hl]  ; Ensure battles are enabled

	ld hl, wd732
	set 0, [hl]  ; Start the game clock

	; Load all the relevant lists to pointers wram
	call GetMinBattlesGameBlueprintFromGameType

	; Get the trainer then run a series of checks
	; on the trainer to determine the party
	farcall GetTrainerAndParty
	farcall DecypherTrainerAndParty
	predef HealParty

	ld a, [wPlayerMinBattlesProgress]
	and a
	jp nz, PostBattle


MinimumBattlesLoop::
	call ClearScreen
	; Start the battle
	callfar InitBattle

	; Check if the player won the battle
	ld a, [wBattleResult]
	cp a, $00
	jr nz, .skipWinBonuses

	farcall GetTrainerAndParty
	farcall AwardGymBadgeAndTM

	; Increment battle progress
	ld a, [wPlayerMinBattlesProgress]
	inc a
	ld [wPlayerMinBattlesProgress], a

	ld c, BANK(Music_Cities1)
	ld a, MUSIC_CITIES1
	ld [wNewSoundID], a

	jr .skipLossPenalties

.skipWinBonuses

	; Check if the player lost or tied the battle
	ld a, [wBattleResult]
	cp a, $00
	jr z, .skipLossPenalties

	; Increment loss counter
	ld a, [wPlayerMinBattlesLosses]
	inc a
	ld [wPlayerMinBattlesLosses], a

	; Set a flag if the player lost to a gym leader
	ld a, [wCurOpponent]
	cp OPP_GYM_LEAD
	jp nz, .notGymLoss
	ld a, [wMinBattlesTemp]
	set 6, a
	ld [wMinBattlesTemp], a
.notGymLoss

	ld c, BANK(Music_Pokecenter)
	ld a, MUSIC_POKECENTER
	ld [wNewSoundID], a

.skipLossPenalties

	call PlayMusic

	predef HealParty
	xor a
	ld [wCurOpponent], a
	ld [wBattleResult], a
	; Get the trainer then run a series of checks
	; on the trainer to determine the party
	; It's near the end of the loop because the end of
	; list identifier is used to go to the Hall of Fame
	farcall GetTrainerAndParty
	farcall DecypherTrainerAndParty
	; fall through to PostBattle


PostBattle:
	call ClearScreen
	call LoadGBPal
	; Open start menu
	call DisplayStartMenu

	jp MinimumBattlesLoop


GetMinBattlesGameBlueprintFromGameType:
	ld a, [wMinBattlesGameType]

	; Game type values start at 1, so we need to subract 1
	; to index into an array properly
	dec a

	; 9x the game type to serve as an array index
	ld b, a
rept 8
	add a, b
endr

	; Load the array index into the bc register
	ld c, a
	ld b, 0
	; index into MinBattlesGameTypes with
	; wTrainerNo * length of trainer_info
	ld hl, MinBattlesGameTypes
	add hl, bc
	; Load the trainer list
	ld a, [hli]
	ld [wMinBattlesTrainerList], a
	ld a, [hli]
	ld [wMinBattlesTrainerList + 1], a
	; Load the gym leader list
	ld a, [hli]
	ld [wMinBattlesGymLeaderList], a
	ld a, [hli]
	ld [wMinBattlesGymLeaderList + 1], a
	; Load the gym badges and tms list
	ld a, [hli]
	ld [wMinBattlesGymBadgeAndTMList], a
	ld a, [hli]
	ld [wMinBattlesGymBadgeAndTMList + 1], a
	; Load the rival leader list
	ld a, [hli]
	ld [wMinBattlesRivalList], a
	ld a, [hli]
	ld [wMinBattlesRivalList + 1], a
	; Load the total count of trainers
	ld a, [hli]
	dec a
	ld [wPlayerMinBattlesProgressTotal], a
	ret


GetTrainerAndParty::
	push af
	ld a, [wPlayerMinBattlesProgress]
	; Double the battles count to serve as an array index
	add a, a
	; Load the array index into the bc register
	ld c, a
	ld b, 0
	ld a, [wMinBattlesTrainerList]
	ld l, a
	ld a, [wMinBattlesTrainerList + 1]
	ld h, a
	add hl, bc
	; Load the trainer class
	ld a, [hli]
	ld [wCurOpponent], a
	; Load the trainer party
	ld a, [hli]
	ld [wTrainerNo], a
	pop af
	ret


DecypherTrainerAndParty::
	ld a, [wCurOpponent]

	; if the end of the list, load the Hall of Fame
	cp OPP_LIST_END
	jr nz, .NotHallofFame
	call GoToHallOfFame
	jp .end
.NotHallofFame
	
	; if rival, load rival data here
	cp OPP_RIVAL
	jr nz, .NotRival
	call GetRivalAndParty
	jp .end
.NotRival

	; if gym leader, load that data here
	cp OPP_GYM_LEAD
	jr nz, .NotGymLeader
	call GetGymLeaderParty
	jp .end
.NotGymLeader

.end
	ret


GetGymLeaderParty::
	; Set the Gym Leader Number so music is correct
	ld a, [wTrainerNo]
	inc a
	ld [wGymLeaderNo], a

	ld a, [wTrainerNo]
	; Double the gym leader index to serve as an array index
	add a, a
	; Load the array index into the bc register
	ld c, a
	ld b, 0
	; index into MinBattlesRedGymLeaderData with
	; wTrainerNo * length of trainer_info
	ld a, [wMinBattlesGymLeaderList]
	ld l, a
	ld a, [wMinBattlesGymLeaderList + 1]
	ld h, a
	add hl, bc
	; Load the trainer class
	ld a, [hli]
	ld [wCurOpponent], a
	; Load the trainer party
	ld a, [hli]
	ld [wTrainerNo], a
	ret


AwardGymBadgeAndTM::
	ld a, [wCurOpponent]
	cp OPP_GYM_LEAD
	ret nz

	ld a, [wTrainerNo]
	; Load the array index into the bc register
	add a
	ld c, a
	ld b, 0
	ld a, [wMinBattlesGymBadgeAndTMList]
	ld l, a
	ld a, [wMinBattlesGymBadgeAndTMList + 1]
	ld h, a
	add hl, bc
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a
	call GiveBadgeAndTM

	ret


GetRivalAndParty::
	ld a, [wTrainerNo]

	; 10x the rival index to serve as an array index
	ld b, a
rept 9
	; White screen when a exceeds 15?
	add a, b
endr
	; Load the array index into the bc register
	ld c, a
	ld b, 0

	; index into wMinBattlesRivalList with
	; wTrainerNo * length of rival_info
	ld a, [wMinBattlesRivalList]
	ld l, a
	ld a, [wMinBattlesRivalList + 1]
	ld h, a
	add hl, bc

	; Load the trainer class
	ld a, [hl]
	ld [wCurOpponent], a

	; Pick party for Rival
	ld de, RivalStartersToTeamLookupList
	ld a, [wRivalStarter]
	call GetRivalTeamStarterIndexLookup

	inc hl
	and a
	jr z, .endLoop
.loop
	inc hl
	dec a
	jr nz, .loop
.endLoop

	; if the Rival's starter is 4 or 5, check wins and losses against the rival
	ld a, [wRivalStarter]
	cp STARTER4
	jr z, .Starter4
	cp STARTER5
	jr nz, .NotStarter5
.Starter4
	; Check wins and losses against the rival here
	; Vaporeon: Lose against Oak's Lab Rival
	; ???
	; Flareon: Lose/Skip Route 22 Rival
	; EVENT_BEAT_ROUTE22_RIVAL_1ST_BATTLE
	; Jolteon: Win both Rival fights
	; Blocked on Oak's Lab win/loss

	; Increment to Flareon for now, as that's the neutral path
	inc hl

.NotStarter5

	ld a, [hl]
	ld [wTrainerNo], a
	ret


GetRivalTeamStarterIndexLookup:
	ld b, a
	xor a
	ld c, a
	; index into RivalStartersToTeamLookupList with a pokemon ID eg. STARTER1
.findStarter
	ld a, [de]
	cp b
	jr z, .foundStarter
	inc de
	inc c
	jr .findStarter
.foundStarter
	ld a, c
	ret


GiveBadgeAndTM::
	; d is badge bit
	; e is tm
	; Dynamically award badges with bit-shifting and OR
	ld a, d
	and a
	ld a, 1
	jr z, .done  ; if it's the first badge, skip the loop
.loop
	add a ; a = a << 1
	dec d
	jr nz, .loop
.done
	ld hl, wObtainedBadges
	or [hl]
	ld [hl], a
	ld hl, wBeatGymFlags
	or [hl]
	ld [hl], a

	ld a, e
	ld b, a
	ld c, 1
	call GiveItemSilent

	ret


GiveItemSilent::
	; Give player quantity c of item b
	ld a, b
	ld [wd11e], a
	ld [wcf91], a
	ld a, c
	ld [wItemQuantity], a
	ld hl, wNumBagItems
	call AddItemToInventory
	ret


GoToHallOfFame:
	xor a
	ld [wPlayerMinBattlesProgress], a
	predef HallOfFamePC
	ld b, 5
.delayLoop
	ld c, 600 / 5
	call DelayFrames
	dec b
	jr nz, .delayLoop
	call WaitForTextScrollButtonPress
	jp Init
