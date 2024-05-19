#!/usr/bin/bash
# generates web resolution versions of emoji
#
for f in $(find highres/ -type f -name "*.png"); do
	emojipath="$(echo $f | sed -e 's/highres/webres/;s/_1200\|_2048//')"
	if [ ! -f $emojipath ]; then
		convert -scale x256 "$f" "$emojipath"
		echo "Downscaled '$f' to '$emojipath'"
	fi
done