#!/bin/sh
files=(ListOfPublicationsOnly PlainListOfPublicationsOnly Dr.PrateekRajGautam_Resume_2023_V01 Dr.PrateekRajGautam_Resume_2023_V01_schooling)
rm PDF -rf
mkdir PDF

for f in ${files[@]}; do
    echo Compiling $f
    pdflatex "./"$f".tex"
    biber ./$f
    pdflatex ./$f".tex"
    pdflatex ./$f".tex"
    ./CleanUpAux.sh
    mv "./"$f".pdf" "./PDF/"$f".pdf"

done
sudo apt install poppler-utils
nix-shell -p poppler-utils
PDF="./Dr.PrateekRajGautam_Resume_2023_V01.pdf"
echo "Converting "$PDF" to image"
cd PDF
pdftoppm -png -r 300 $PDF PNG
cd ..
echo "\n Command Completed"
