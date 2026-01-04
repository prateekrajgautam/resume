#!/bin/bash
set -e  # Exit on any error

files="ListOfPublicationsOnly PlainListOfPublicationsOnly Dr.PrateekRajGautam_Resume_2026_V01 Dr.PrateekRajGautam_Resume_2026_V01_schooling"

echo "Cleaning old PDF directory..."
rm -rf "./PDF"
mkdir -p "PDF"

clearaux(){
    echo "  Cleaning auxiliary files..."
    filetypes='aux out log lof lot toc ind ilg idx glo bcf maf ist glsdefs mtc0 mtc gls glg 2i 2o blg run.xml bbl mtc* mlf* mlt* ptc* plf* plt* nav snm synctex.gz'
    for i in $filetypes; do
        rm -f ./*.$i 2>/dev/null || true  # -f forces, || true prevents exit
    done
}

compiletex(){
    f="$1"
    echo ""
    echo "  Compiling: $f"
    pdflatex -interaction=nonstopmode "./$f.tex" > /dev/null 2>&1 || true
    biber ./$f > /dev/null 2>&1 || true
    pdflatex -interaction=nonstopmode "./$f.tex" > /dev/null 2>&1 || true
    pdflatex -interaction=nonstopmode "./$f.tex" > /dev/null 2>&1 || true
    
    if [ -f "./$f.pdf" ]; then
        mv "./$f.pdf" "./PDF/$f.pdf"
        echo "  ✓ Successfully compiled: $f.pdf"
    else
        echo "  ✗ Failed to compile: $f.pdf"
    fi
    clearaux
}

echo "=========================================="
echo "Starting LaTeX Compilation"
echo "=========================================="

for f in $files; do
    echo ""
    echo "----------------------------------------"
    echo "Processing: $f"
    echo "----------------------------------------"
    compiletex "$f"  # Use quotes around variable
done

echo ""
echo "=========================================="
echo "Generating PNG Previews"
echo "=========================================="

cd PDF
pwd 
ls -lh

PDF="Dr.PrateekRajGautam_Resume_2026_V01.pdf"  # No ./ prefix needed
if [ -f "$PDF" ]; then
    echo "Converting $PDF to PNG images..." 
    pdftoppm -png -r 300 "$PDF" PNG && echo "✓ PNG conversion complete"
    ls PNG-*.png 2>/dev/null | xargs -I {} echo {} > imagelist.txt || true
else
    echo "✗ Warning: $PDF not found, skipping PNG conversion"
fi

cd ..

echo ""
echo "=========================================="
echo "Compilation Summary"
echo "=========================================="
echo "Generated PDFs:"
ls -lh PDF/*.pdf 2>/dev/null || echo "No PDFs generated!"
echo "=========================================="
