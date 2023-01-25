# Generation One Minimum Battles Simulator

Dive right in to Gen 1 battles!

This romhack is a "minimum battles" simulator for Pokémon's first generation.  It was inspired by [JRose11's][jrose11] phenomenal Minimum Battles videos on YouTube ([Red][jrose11-min-battles-red], [Yellow][jrose11-min-battles-yellow]).  It was built using [pokeyellow][pokeyellow] as a base.  Currently the Game Corner trainers are skipped.  Check trainer lists [here][min-battles-data].

Your losses will be tracked, as well as the number of Rare Candies you use.  If you can beat Yellow Version, you'll unlock Red Version!


## Installation

Installation will generate a romfile called `minbattles.gbc` with `sha1` hash of `14f11fd5adaaea2cc2f2f75e15708f47372777fe`.

### Classic Installation

Follow [**INSTALL.md**][install]

### Docker Installation

Run `./build.sh` to have [Docker][docker] do the heavy lifting and requirements management for you.  `./build.sh` puts the `.gbc` file in the `output` folder.


## Frequently Asked Questions

**Q:** Where can I download a `.gb`/`.gbc` file?

**A:** Rom files are unavailable for download.  I have no interest in sharing my roms because I don't know at what point they're significantly different enough from Pokémon Yellow that I won't have Nintendo's lawyers at my door.


**Q:** Have you thought about addding \[feature\]?

**A:** Have you checked the [issues page][issues]?  You can even [create a new issue][new-issue] if your idea isn't yet documented!


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
[install]: INSTALL.md
[docker]: https://www.docker.com/products/docker-desktop/
[issues]: https://github.com/gofastlily/gen-1-minimum-battles/issues
[new-issue]: https://github.com/gofastlily/gen-1-minimum-battles/issues/new
[pret]: https://github.com/pret
