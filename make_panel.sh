#!/bin/sh

# Input:            Paper/24x24/{panel,animations}/*.svg
# Output:           Paper/22x22/{panel,animations}/*.svg
#         Paper-Mono-Dark/22x22/{panel,animations}/*.svg
#         Paper-Mono-Dark/24x24/{panel,animations}/*.svg

# Base is 24x24; we need to re-write `viewBox="0 0 24 24"` to `viewBox="1 1 22 22"`
# to crop it to 22x22. Instead, to enlarge 22x22 to 24x24 we need "-1 -1 24 24"
# which will add 2 bytes.
# Paper's main color is #dbdee0 and it should be redefined to #555555 (#555) when
# we make the Paper-Mono-Dark icons.


here="$(dirname "$0")"

for i in animations panel; do
	for j in $(find "$here/Paper/24x24/$i" -type f); do
		echo -n '.'
		name=$(basename "$j")

		sed 's|viewBox="0 0 24 24"|viewBox="1 1 22 22"|'                  "$j" > "$here/Paper/22x22/$i/$name"
		sed 's|viewBox="0 0 24 24"|viewBox="1 1 22 22"|;s|#dbdee0|#555|g' "$j" > "$here/Paper-Mono-Dark/22x22/$i/$name"
		sed                                            's|#dbdee0|#555|g' "$j" > "$here/Paper-Mono-Dark/24x24/$i/$name"
	done
done
echo
