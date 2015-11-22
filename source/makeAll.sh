#!/bin/bash

mkdir -p generated

for i in {1..26}
do
   openscad -o generated/morgan-${i}.stl -D"MakeMorgan(${i});" Reprap_Morgan.scad
done
