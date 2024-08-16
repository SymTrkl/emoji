# misskey-compatible meta.json generator
#
# IMPORTANT!
# this script is meant to be called from pack.sh!
# it is assumed that the passed value has already been sanity-checked!
# subdirectories in the emoji directory will probably break this

import json
import sys
import os

folder = sys.argv[1]
relpath = "webres/" + folder # edit this to use this script in another environment
relfile = relpath + "/meta.json"

emojis = []

for filename in os.listdir(relpath):
	if filename != "meta.json":
		emojis.append({
			"downloaded": True,
			"fileName":  filename,
			"emoji": {
				"name": filename.rsplit(".")[0],
				"category":folder.capitalize(),
				"aliases": []
			}
		})

output = {"emojis": emojis}

outfile = open(relfile, "w")
outfile.write(json.dumps(output))
outfile.close()
