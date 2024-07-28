#!/bin/sh
nix-shell -p poppler_utils --run 'PDF="./Dr.PrateekRajGautam_Resume_2023_V01.pdf" && echo "Converting "$PDF" to image" && cd PDF && pdftoppm -png -r 300 $PDF PNG && cd .. && echo "\n Command Completed"'
apt install sudo -y
sudo apt install poppler-utils -y
nix-shell -p poppler_utils
PDF="./Dr.PrateekRajGautam_Resume_2023_V01.pdf"
echo "Converting "$PDF" to image"
cd PDF
pdftoppm -png -r 300 $PDF PNG
cd ..
echo "\n Command Completed"

ls *.png | xargs -I {} echo {} > imagelist.txt


