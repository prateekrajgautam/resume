#!/bin/sh
files="ListOfPublicationsOnly PlainListOfPublicationsOnly Dr.PrateekRajGautam_Resume_2024_V01 Dr.PrateekRajGautam_Resume_2024_V01_schooling"
#files=(ListOfPublicationsOnly PlainListOfPublicationsOnly Dr.PrateekRajGautam_Resume_2024_V01 Dr.PrateekRajGautam_Resume_2024_V01_schooling)
rm PDF -rf
mkdir PDF

for f in $files; do
#for f in ${files[@]}; do
    echo Compiling $f
    pdflatex "./"$f".tex"
    biber ./$f
    pdflatex ./$f".tex"
    pdflatex ./$f".tex"
    ./CleanUpAux.sh
    mv "./"$f".pdf" "./PDF/"$f".pdf"

done

./pdftopng

