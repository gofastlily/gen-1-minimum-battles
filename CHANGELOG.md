# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## Unreleased
### Added
- Immediately battle Rival 1
- Go to Hall of Fame on a win
- Re-battle Rival 1 on a loss
- Options menu item to enable or disable nicknaming on capture

### Changed
- Refactored the main menu to leverage the new `MenuCore`
- Options
    - Text speed: Fast
    - Animation: Off
    - Battle Style: Set
    - Nickname: Off
- Select default player names by default

### Removed
- Oak's intro dialogue
- A lot of unused data

### Known issues
- Re-battle intro animation is broken
- Player Pokémon sprite is missing in battle
- Visual glitches at end of Hall of Fame
- Audio glitches at end of Hall of Fame
- Going into the options menu forces nicknaming on
