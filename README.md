# Phonopy VASP Method
Roughly following [this tutorial](https://phonopy.github.io/phonopy/vasp.html) on the Phonopy Github page and [this tutorial](https://www.youtube.com/watch?v=FX7WjL074g4) on youtube (_Phonon Calculations in Materials Science using VASP & phonopy by Rasoul Khaledi_).

## Relaxation
Find or create a [POSCAR](./Relaxation/POSCAR) for the desired structure. [Materials Project](https://next-gen.materialsproject.org/materials) is a useful database for structures. Relax the POSCAR file using VASP. This will require appropriate [INCAR](./Relaxation/INCAR), [KPOINTS](./Relaxation/KPOINTS), and POTCAR files. In best practices, the kpoints (in the KPOINTS file) and ENCUT (in the INCAR file) used in the relaxation steps should be converged appropriately. The relaxed output CONTCAR will be used as the input [POSCAR](./Forces/POSCAR) in future steps.
## Pre-process
To choose the supercell, refer to the relaxed [POSCAR](./Forces/POSCAR). A 2 2 2 supercell is typical, but a noncubic unit cell might need more or fewer cells along a certain axis. For example, the Si unit cell is cubic and a 2 2 2 supercell is sufficient for the purposes of this example. A supercell as large as 4 4 4 can be used for VASP, but is not recommended as it requires a longer calculation.
To generate the 2 2 2 supercell with no symmetry and automatic primitive axes, replace <POSCAR> with the name of the POSCAR file, ie POSCAR or POSCAR-unitcell:  
`phonopy -d --dim 2 2 2 --nosym --pa auto -c <POSCAR> `  
This will generate a number of POSCAR-_{number}_ files to be used in the next step.  
## Force Calculation
Calculations using the finite displacement method are completed through force calculations on the generated POSCAR-_{number}_ files. This will require appropriate [INCAR](./Forces/INCAR), [KPOINTS](./Forces/KPOINTS), and POTCAR files.  
It is important that in this calculation step the structures are **not** relaxed.   
The KPOINT mesh may be relatively small, in the provided example a Gamma mesh of 6 6 6 is used.   
Copy each POSCAR-_{number}_ into a _{number}_ directory along with INCAR, KPOINTS, and POTCAR files. The [prepare_vasp.sh](./Forces/prep-phonopy.sh), [batch_submit_vasp.sh](./Forces/submit.sh) bash scripts can help in automating this process. In order to run .sh files, the permissions may need to be changed using the chmod command.  
`chmod +x ./<filename.sh>`   
Once the calculation has completed, create FORCE_SETS using phonopy, with <dirs> being the names of the force calculation directories, ie 0*/ or {001..012}/ or disp-*/. 
`phonopy -f <dirs>/vasprun.xml`  
## Post-process
The following commands are used to generate plottable data as well as phonopy-generated plots. The -s tag will save each plot as a pdf. Configuration files are useful for this process. [Mesh.conf](./Forces/mesh.conf) is used to generate the Phonon Density of States (DOS) and Thermal Properties data.  
### Phonon DOS:
`phonopy-load -p -s mesh.conf`  
### Thermal Properties:
`phonopy-load -p -s -t mesh.conf`  
### Band Structure:
[Band.conf](./Forces/band.conf) is used to generate the Phonon Band Structure.  
`phonopy-load -p -s band.conf`  
  
It is recommended to plot this data in Python, as in [phonopy-plot.ipynb](./phonopy-plot.ipynb). 
## Phonopy Setup (ARCC HPC)
The Python module Phonopy has to be installed manually onto the arcc using conda. [This page](https://phonopy.github.io/phonopy/install.html) on the phonopy github has a useful tutorial, as well as [this page](https://arccwiki.atlassian.net/wiki/spaces/DOCUMENTAT/pages/7504145/Miniconda#Install-Packages-into-a-Miniconda-Environment-in-Your-Home-Directory) on the arcc wiki. To activate the phonopy conda environment, enter the following and replace <phonopy-env> with the name of the conda phonopy environment:  
`% module load miniconda3/23.11.0  
% conda activate _<phonopy-env>_`  
It is best practice to use an interactive node while running phonopy commands, the command for which on Medicine Bow is:
`% srun -n 2 -N 1 -t 2:00:00 -A <account> --pty /bin/bash -l`
