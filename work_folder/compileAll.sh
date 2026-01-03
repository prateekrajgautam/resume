#!/bin/bash
set -e  # Exit on any error

files="ListOfPublicationsOnly PlainListOfPublicationsOnly Dr.PrateekRajGautam_Resume_2026_V01 Dr.PrateekRajGautam_Resume_2026_V01_schooling"

echo "Cleaning old PDF directory..."
rm -rf "./PDF"
mkdir -p "PDF"

for f in $files; do
    echo "=========================================="
    echo "Compiling: $f"
    echo "=========================================="
    
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
done

# Clean auxiliary files
./CleanUpAux.sh

# Generate PNG previews
if [ -f ./pdftopng.sh ]; then
    cp ./pdftopng.sh ./PDF/pdftopng.sh
    cd PDF
    ./pdftopng.sh
    rm ./pdftopng.sh
    cd ..
fi

echo "=========================================="
echo "Compilation complete!"
echo "=========================================="
ls -lh PDF/*.pdf
