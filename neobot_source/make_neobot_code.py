import subprocess
import re
import os

INKSCAPE_PATH = "C:\\Program Files\\Inkscape\\bin\\inkscape.com"

neobot_super = None
with open("neobot_source/neobot_screen2.svg") as in_file:
    neobot_super = in_file.read()

for logo_file in os.scandir("./neobot_source/devicons"):
    language, variant = re.match(r"(.*)-(.*)\.svg", logo_file.name).groups()
    temp = re.sub("python-plain", f"{language}-{variant}", neobot_super)
    with open("neobot_source/temp.svg", "w") as out_file:
        out_file.write(temp)
    subprocess.run(f"{INKSCAPE_PATH} neobot_source\\temp.svg -w 256 -h 256 --export-filename=webres\\neobot\\code\\neobot_code_{language}.png")
    subprocess.run(f"{INKSCAPE_PATH} neobot_source\\temp.svg -w 2048 -h 2048 --export-filename=highres\\neobot\\code\\neobot_code_{language}_2048.png")