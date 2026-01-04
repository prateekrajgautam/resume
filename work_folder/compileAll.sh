#!/bin/bash
set -e  # Exit on any error

files="ListOfPublicationsOnly PlainListOfPublicationsOnly Dr.PrateekRajGautam_Resume_2026_V01 Dr.PrateekRajGautam_Resume_2026_V01_schooling"

echo "Cleaning old PDF directory..."
rm -rf "./PDF"
mkdir -p "PDF"

clearaux(){
    filetypes='aux out log lof lot toc ind ilg idx glo bcf maf ist glsdefs mtc0 mtc gls glg 2i 2o blg run.xml bbl mtc* mlf* mlt* ptc* plf* plt* nav snm synctex.gz'
    for i in $filetypes; do
	    rm ./*.$i
    done
}

compiletex(){
    f="$1"
    echo -e "\n  compuletex is Compiling $f"
    pdflatex -interaction=nonstopmode "./$f.tex" || true
    biber ./$f || true
    pdflatex -interaction=nonstopmode "./$f.tex" || true
    pdflatex -interaction=nonstopmode "./$f.tex" || true
    
    if [ -f "./$f.pdf" ]; then
        mv "./$f.pdf" "./PDF/$f.pdf"
        echo "✓ Successfully compiled $f.pdf"
    else
        echo "✗ Failed to compile $f.pdf"
    fi
    clearaux
}


for f in $files; do
    echo "=========================================="
    echo "Compiling: $f of $files"
    echo "=========================================="
    compiletex $f
    clearaux
done





# Generate PNG previews
echo -e "\nGenerate PNG previews\n\n"
pwd
cd PDF
pwd 
ls

PDF="./Dr.PrateekRajGautam_Resume_2026_V01.pdf" 
echo "Converting "$PDF" to image" 
pdftoppm -png -r 300 $PDF PNG && echo -e "Command Completed" 
ls *.png | xargs -I {} echo {} > imagelist.txt
cd ..



echo "=========================================="
echo "Compilation complete!"
echo "=========================================="
ls -lh PDF/*.pdf
cd ..
ls -al
pwd 
tree
