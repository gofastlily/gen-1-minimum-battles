#!/usr/bin/env nix-shell 
#! nix-shell -i bash --pure
#! nix-shell -p bash cacert gnumake gcc git rgbds 

# The -c flag runs make clean
if [ "$1" == "-c" ]; then
  make clean
fi

make
