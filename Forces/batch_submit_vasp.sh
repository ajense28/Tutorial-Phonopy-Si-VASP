#===============================================================================
# Author: ajense28
# Date:   25 Oct 2024
# Description: 
# Batch submits $disp number of displacements using a submit_dftb script,
# written for vasp phonon calculations.
# to run: ./batch_submit_vasp.sh
# may need to change permissions: chmod 755 batch_submit_vasp.sh
#===============================================================================

read -p "Enter number of displacements: " disp  # get user input
echo 'Submitting' $disp 'jobs.'

for i in `seq 1 $disp `;
do
cd disp-"$i"    # directories named with disp-i NO ZEROS
# ./submit_vasp <no-of-tasks> <no-of-CPUS-per-task> <job-name>
sbatch ./submit_vasp 1 1 vaspcalc_"$i"
cd ..
        echo $i
done
