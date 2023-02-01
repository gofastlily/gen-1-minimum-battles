# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## Unreleased
### Added
- Beating the game with Eevee unlocks a Thunder Stone for use with Pikachu

### Fixed
- Selecting Eevee no longer gives Onix to the player

### Known Issues
- Screen goes white after a Pokémon evolves from the items menu
- Evolving after battle works but causes graphical glitches in the between-battle menu


## v0.3.1
### Added
- Generate patches and hashes in `./build.sh` for convenience
- Include `HASHES.md` with hashes for roms, patches, and the `.map` and `.sym` files

### Fixed
- Mystery compile-time issue and left a comment in `engine/menus/menu_core.asm`.


## v0.3.0
### Added
- Use Red starters in Yellow and Yellow Starters in Red (beat Red and Yellow with all their respective starters)
- Picking Eevee gives the player a Fire Stone, a Thunder Stone, and a Water Stone

### Fixed
- Pressing `B` no longer gives the player Kangaskhan as a starter
- Picking Squirtle and Bulbasaur as starters have been fixed


## v0.2.0
### Added
- Unlocks Menu (Visible after beating the game once)
- Eevee as a Yellow Version starter (Beat Red once)


## v0.1.1
### Added
- Player can now run from battles (this counts as a loss)

### Changed
- Quarter second pause when calling `DisplayStartMenu` to help prevent accidentally starting the next fight


## v0.1.0
### Added
- Minimum Battles Mode
- Options menu item to enable or disable nicknaming on capture
- Counter for use of Rare Candies
- 95 Rare Candies to the player's bag
- Counter for player losses

### Changed
- Refactored the main menu to leverage the new `MenuCore`
- Options
    - Text speed: Fast
    - Animation: Off
    - Battle Style: Set
    - Nickname: Off
- Select default player names by default
- Replaced the Pokédex in the start menu with Continue
- Replaced Exit in the start menu with Quit

### Removed
- Oak's intro dialogue
- A lot of unused data
