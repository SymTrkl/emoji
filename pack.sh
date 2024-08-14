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
	jsonfile=webres/$1/meta.json
	# check if dir exists
	if [ ! -d $emojidir ]; then
		echo "ERROR: Directory '$1' does not exist."
	# check if dir is empty (apparently read NEEDS a variable :/ )
	elif find $emojidir -mindepth 1 -maxdepth 1 | read ugh; then
		# remove old files
		if [ -f $zipfile ]; then
			rm $zipfile
		fi
		if [ -f $tarfile ]; then
			rm $tarfile
		fi
		if [ -f $jsonfile ]; then
			rm $jsonfile
		fi
		# generate .tar.gz for masto/akkoma
		tar -czf $tarfile -C webres $1
		if [ -f $tarfile ]; then
			echo "Created '$tarfile' sucessfully!"
		fi
		# generate meta.json
		python3 pack_json.py $1
		if [ -f $jsonfile ]; then
			echo "Created '$jsonfile' sucessfully!"
		fi
		# generate .zip for misskey
		zip -jq $zipfile $emojidir/*
		if [ -f $zipfile ]; then
			echo "Created '$zipfile' sucessfully!"
		fi
	else
		echo "ERROR: Directory '$1' is empty."
	fi
fi