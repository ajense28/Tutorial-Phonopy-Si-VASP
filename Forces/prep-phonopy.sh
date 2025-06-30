#!/bin/bash
# Author: Alison Jensen # Date: 6/25/25
# filename: prep-phonopy.sh
# creates directories for phonopy (qha varied volume) force calculation and populates them
# may need to do chmod 775 prep-phonopy.sh

dir=$(pwd)
for p in POSCAR-*; do
    d=$(cut -d "-" -f2 <<< "$p")
    mkdir -p "$dir"/"$d"
    cp $p "$dir"/"$d"/POSCAR
    cp INCAR KPOINTS POTCAR "$dir"/"$d"/.
done
