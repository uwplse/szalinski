find . -name '*.scad' -exec sh -c 'openscad -o "${0%.scad}.csg" "$0"' {} \;
find . -name '*.csg' -exec sh -c 'mv "$0" "${0%.csg}.altscad"' {} \;
find . -name '*.altscad' -exec sh -c '../../Main.native --src "$0" --tgt "${0%.altscad}.csexp"' {} \;