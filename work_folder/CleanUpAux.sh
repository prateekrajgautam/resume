#!/bin/sh
# Clean Auxilary files from Latex Folder
filetypes='aux out log lof lot toc ind ilg idx glo bcf maf ist glsdefs mtc0 mtc gls glg 2i 2o blg run.xml bbl mtc* mlf* mlt* ptc* plf* plt* nav snm synctex.gz'
for i in $filetypes; do
	rm ./*.$i
done




#!/bin/bash
# Clean Auxilary files from Latex Folder
#filetypes=(aux out log lof lot toc ind ilg idx glo bcf maf ist glsdefs mtc0 mtc gls glg 2i 2o blg run.xml bbl mtc* mlf* mlt* ptc* plf* plt* nav snm synctex.gz)
#for i in ${filetypes[@]}; do
#	rm ./*.$i
#done


