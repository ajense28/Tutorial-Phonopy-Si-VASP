#===============================================================================
# Author: ajense28
# Date:   25 Oct 2024
# Description: 
# Shell script to generate $disp directories and copy in all necessary input
# files for a vasp calculation, written for vasp phonon calcs.
# Note that directories follow the disp-$i naming convention but copy in POSCAR
# files with varying amounts of leading zeros based on the number of 
# displacements.
# to run: ./prepare_vasp.sh
# may need to change permissions: chmod 755 prepare_vasp.sh
#===============================================================================

#!/bin/bash

read -p "Enter number of displacements: " disp  # Get user input
echo 'Generating directories for' $disp 'displacements'

if [ $disp -lt 10 ]; then
        for i in `seq 1 $disp `;
        do
        mkdir disp-"$i"
        cd disp-"$i"   
        cp ../submit_vasp .
        cp ../KPOINTS .
        cp ../INCAR .
        cp ../POTCAR .
        cp ../POSCAR-00"$i" POSCAR 
                echo $i
        cd ..
        done
        
elif [ $disp -lt 100 ]; then
        for i in `seq 1 9 `;
        do
        mkdir disp-"$i"
        cd disp-"$i"   
        cp ../submit_vasp .
        cp ../KPOINTS .
        cp ../INCAR .
        cp ../POTCAR .
        cp ../POSCAR-00"$i" POSCAR 
                echo $i
        cd ..
        done
        
        for i in `seq 10 $disp `;
        do
        mkdir disp-"$i"
        cd disp-"$i"   
        cp ../submit_vasp .
        cp ../KPOINTS .
        cp ../INCAR .
        cp ../POTCAR .
        cp ../POSCAR-0"$i" POSCAR 
                echo $i
        cd ..
        done
        
elif [ $disp -lt 1000 ]; then
        for i in `seq 1 9 `;
        do
        mkdir disp-"$i"
        cd disp-"$i"   
        cp ../submit_vasp .
        cp ../KPOINTS .
        cp ../INCAR .
        cp ../POTCAR .
        cp ../POSCAR-0000"$i" POSCAR 
                echo $i
        cd ..
        done

        for i in `seq 10 99 `;
        do
        mkdir disp-"$i"
        cd disp-"$i"   
        cp ../submit_vasp .
        cp ../KPOINTS .
        cp ../INCAR .
        cp ../POTCAR .
        cp ../POSCAR-000"$i" POSCAR 
                echo $i
        cd ..
        done
        
        for i in `seq 100 $disp `;
        do
        mkdir disp-"$i"
        cd disp-"$i"   
        cp ../submit_vasp .
        cp ../KPOINTS .
        cp ../INCAR .
        cp ../POTCAR .
        cp ../POSCAR-00"$i" POSCAR 
                echo $i
        cd ..
        done
fi


        


