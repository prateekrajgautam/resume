#!/bin/sh
nix-shell -p poppler_utils --run 'PDF="./Dr.PrateekRajGautam_Resume_2025_V01.pdf" && echo "Converting "$PDF" to image" && cd PDF && pdftoppm -png -r 300 $PDF PNG && cd .. && echo -e "\n Command Completed\n" && ls *.png | xargs -I {} echo {} > imagelist.txt'
nix-shell -p poppler_utils --run 'PDF="./Dr.PrateekRajGautam_Resume_2025_V01.pdf" && echo "Converting "$PDF" to image" && pdftoppm -png -r 300 $PDF PNG && echo -e "\n Command Completed\n" && ls *.png | xargs -I {} echo {} > imagelist.txt'
# apt install sudo -y
# sudo apt install poppler-utils -y
# nix-shell -p poppler_utils
# PDF="./Dr.PrateekRajGautam_Resume_2025_V01.pdf"
# echo "Converting "$PDF" to image"
# cd PDF
# pdftoppm -png -r 300 $PDF PNG
# cd ..
# echo "\n Command Completed"

# ls *.png | xargs -I {} echo {} > imagelist.txt


