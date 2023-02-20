#!/usr/bin/env nix-shell 
#! nix-shell -i bash --pure
#! nix-shell -p bash cacert cmake clang git rgbds

make clean
make
