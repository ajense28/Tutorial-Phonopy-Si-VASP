# Get user input
read -p "Enter number of displacements: " disp
echo 'Removing directories for' $disp 'displacements'

if [ $disp -lt 10 ]; then
        for i in `seq 1 $disp `;
        do
        rm -r disp-000"$i"
                echo $i
        done
        
elif [ $disp -lt 100 ]; then
        for i in `seq 1 9 `;
        do
        rm -r disp-000"$i"
                echo $i
        done
        
        for i in `seq 10 $disp `;
        do
        rm -r disp-00"$i"
                echo $i
        done
        
elif [ $disp -lt 1000 ]; then
        for i in `seq 1 9 `;
        do
        rm -r disp-00"$i"
                echo $i
        done

        for i in `seq 10 99 `;
        do
        rm -r disp-0"$i"
                echo $i
        done
        
        for i in `seq 100 $disp `;
        do
        rm -r disp-00"$i"
                echo $i
        done
fi
