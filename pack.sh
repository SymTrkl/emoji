#!/usr/bin/bash
# creates importable packs
# usage: pack.sh [dir]
# where [dir] is a subdirectory in webres
#
# check for params
if [ $# = "0" ]; then
	echo "ERROR: No directory specified."
else
	emojidir=webres/$1
	zipfile=releases/$1.zip
	tarfile=releases/$1.tar.gz
	# check if dir exists
	if [ ! -d $emojidir ]; then
		echo "ERROR: Directory '$1' does not exist."
	#check if dir is empty (apparently read NEEDS a variable :/ )
	elif find $emojidir -mindepth 1 -maxdepth 1 | read ugh; then
		# if .zip exists, remove it so kainoa's tool doesn't choke
		if [ -f $zipfile ]; then
			rm $zipfile
		fi
		emoji-gen local --folder $emojidir --output $zipfile
		tar -czf $tarfile -C webres $1
		if [ -f $tarfile ]; then
			echo "Created '$tarfile' sucessfully!"
		fi
	else
		echo "ERROR: Directory '$1' is empty."
	fi
fi