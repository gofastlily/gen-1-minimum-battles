#!/usr/bin/env nix-shell 
#! nix-shell -i bash --pure
#! nix-shell -p bash cacert gnumake gcc git rgbds gawk which haskellPackages.cryptohash-sha1

# The -c flag runs make clean
if [ "$1" == "-c" ]; then
  make clean
fi
make

# Document the free space
echo "\`\`\`" > FREE_SPACE.md
tools/free_space.awk BANK=all pokeyellow.map >> FREE_SPACE.md
echo "\`\`\`" >> FREE_SPACE.md

# Generate a file hash
echo "\`\`\`" > HASHES.md
sha1sum pokeyellow.gbc pokeyellow.sym pokeyellow.map >> HASHES.md
sha1sum pokeyellow_debug.gbc pokeyellow_debug.sym pokeyellow_debug.map >> HASHES.md
echo "\`\`\`" >> HASHES.md
