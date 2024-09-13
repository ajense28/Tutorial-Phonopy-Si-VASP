# get user input
read -p "Enter number of displacements: " disp
echo 'Submitting' $disp 'calculations'

if [ $disp -lt 10 ]; then
        for i in `seq 1 $disp `;
        do
        cd disp-000"$i"
        sbatch ./run_vasp.sh3
        cd ..
                echo $i
        done
        
elif [ $disp -lt 100 ]; then
        for i in `seq 1 9 `;
        do
        cd disp-000"$i"
        sbatch ./run_vasp.sh3
        cd ..
                echo $i
        done
        
        for i in `seq 10 $disp `;
        do
        cd disp-00"$i"
        sbatch ./run_vasp.sh3
        cd ..
                echo $i
        done
        
elif [ $disp -lt 1000 ]; then
        for i in `seq 1 9 `;
        do
        cd disp-000"$i"
        sbatch ./run_vasp.sh3
        cd ..
                echo $i
        done

        for i in `seq 10 99 `;
        do
        cd disp-00"$i"
        sbatch ./run_vasp.sh3
        cd ..
                echo $i
        done
        
        for i in `seq 100 $disp `;
        do
        cd disp-0"$i"
        sbatch ./run_vasp.sh3
        cd ..
                echo $i
        done
fi