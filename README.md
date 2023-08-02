# Generation One Minimum Battles Simulator

Dive right in to Gen 1 battles!

This romhack is a "minimum battles" simulator for Pokémon's first generation.  It was inspired by [JRose11's][jrose11] phenomenal Minimum Battles videos on YouTube ([Red][jrose11-min-battles-red], [Yellow][jrose11-min-battles-yellow]).  It was built using [pokeyellow][pokeyellow] as a base.  Currently the Game Corner trainers are skipped.  Check trainer lists [here][min-battles-data].

Your losses will be tracked, as well as the number of Rare Candies you use.  If you can beat Yellow Version, you'll unlock Red Version!


## What People are Saying

> Feels more like an arcade mode than a "hack"
>
> \- Axeljk


## Installation

### Easy Installation

Download `minbattles.bps` and patch `pokeyellow.gbc` to generate `minbattles.gbc`.

Hashes can be found in [`HASHES.md`][hashes]


### Classic Installation

Follow [**`INSTALL.md`**][install]

### Nix Installation

Run `./build.sh` to have [Nix][nix] do the heavy lifting and requirements management for you.


## Frequently Asked Questions

**Q:** Where can I download a `.gb`/`.gbc` file?

**A:** Rom files are unavailable for download.  I have no interest in sharing my roms because I don't know at what point they're significantly different enough from Pokémon Yellow that I won't have Nintendo's lawyers at my door.


**Q:** Have you thought about addding \[feature\]?

**A:** Have you checked the [issues page][issues]?  You can even [create a new issue][new-issue] if your idea isn't yet documented!


**Q:** Do you provide a `.sym` or `.map` file for this romhack?

**A:** As of release [`v0.3.1`][v0.3.1] we provide both the `.sym` and `.map` files, along with their hashes in [`HASHES.md`][hashes].


## Special Thanks

- Rangi
- 33dannye
- Chatot4444
- Jojobear13
- Vortiene
- ax6
- Vulcandth
- Chloerawr
- CelestialAmber
- Vimescarrot
- IIMarckus
- Snarflaxus
- SatoMew
- Mord
- Sea
- LJSTAR
- Rainbow Metal Pigeon
- The entire [pret][pret] team
- GameFreak


[jrose11]: https://www.youtube.com/@Jrose11
[jrose11-min-battles-red]: https://www.youtube.com/watch?v=yigDp4JNRL0
[jrose11-min-battles-yellow]: https://www.youtube.com/watch?v=MYsuGVH6C8c
[pokeyellow]: https://github.com/pret/pokeyellow
[min-battles-data]: main/data/min_battles
[hashes]: HASHES.md
[install]: INSTALL.md
[nix]: https://nixos.org/
[issues]: https://github.com/gofastlily/gen-1-minimum-battles/issues
[new-issue]: https://github.com/gofastlily/gen-1-minimum-battles/issues/new
[pret]: https://github.com/pret
[v0.3.1]: https://github.com/gofastlily/gen-1-minimum-battles/releases/tag/v0.3.1
