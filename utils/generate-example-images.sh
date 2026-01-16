#!/bin/bash

set -e

cd examples
for SCAD_FILE in *.scad
do
    filename=$(basename -- "$SCAD_FILE")
    cat /dev/null > temp.scad
    cat "$SCAD_FILE" | sed "s/block(/color( \"lightgray\" ) block(/g" >> temp.scad
    basename="${filename%.*}"
    echo "$basename"
    openscad --enable predictible-output -D \$fa=1 -D \$fs=0.1 --render --colorscheme Nature --imgsize=1024,1024 --backend Manifold --viewall --render --projection p --autocenter -o "images/$basename.png" temp.scad
    rm temp.scad

    magick "images/$basename.png" -resize 256x256 "images/$basename.png"

    rm -f images/temp.png
done;
