#!/usr/bin/env nix-shell 
#! nix-shell -i bash --impure
#! nix-shell -p bash cacert gnumake gcc git rgbds which haskellPackages.cryptohash-sha1

# The -c flag runs make clean
if [ "$1" == "-c" ]; then
  make clean
fi
make

# Generate a BPS file
# Currently relies on the --impure flag because there isn't a nixpkgs BPS generator for aarch64-darwin
command -v multipatch 1> /dev/null 
if [ $? -eq 0  ] && [ -d "../pokeyellow" ]; then
  multipatch --create ../pokeyellow/pokeyellow.gbc minbattles.gbc minbattles.bps
  multipatch --create ../pokeyellow/pokeyellow_debug.gbc minbattles_debug.gbc minbattles_debug.bps
else
  echo "unable to generate a patch file"
fi

# Generate a file hash
echo "\`\`\`" > HASHES.md
sha1sum minbattles.gbc minbattles.bps minbattles.sym minbattles.map >> HASHES.md
sha1sum minbattles_debug.gbc minbattles_debug.bps minbattles_debug.sym minbattles_debug.map >> HASHES.md
echo "\`\`\`" >> HASHES.md
