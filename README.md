Phonopy Setup (ARCC HPC)
The Python module Phonopy has to be installed manually onto Southpass/MedicineBow using conda. This   page on the phonopy github is useful, as well as this  page on the arcc wiki. To activate the phonopy conda environment, enter the following and replace <phonopy-env> with the name of the conda phonopy environment:
% module load miniconda3/23.11.0
% conda activate <phonopy-env>
Phonopy VASP Method
Roughly following this  tutorial on the Phonopy Github page and this  tutorial on youtube (Phonon Calculations in Materials Science using VASP & phonopy by Rasoul Khaledi).
Relaxation
Find or create a POSCAR for the desired structure. Materials Project is useful for this. Relax the POSCAR file using VASP. This will require appropriate INCAR, KPOINTS, and POTCAR files (Appendix 1.1 ). The relaxed output CONTCAR will be used as the POSCAR in future steps.
Pre-process
To choose the supercell, refer to the relaxed POSCAR. A 2 2 2 supercell is normal, but a noncubic unit cell might need more or fewer cells along a certain axis. For example, the Si unit cell is cubic and a 2 2 2 supercell is sufficient. A supercell as large as 4 4 4 can be used for VASP, but is not recommended as it increases runtime exponentially.
To generate the 2 2 2 supercell with no symmetry and automatic primitive axes, replace <POSCAR> with the name of the POSCAR file, ie POSCAR or POSCAR-unitcell:
% phonopy -d --dim 2 2 2 --nosym --pa auto -c <POSCAR> 
This will generate a number of POSCAR-{number} files to be used in the next step.
Force Calculation
Calculations using the finite displacement method are completed through force calculations on the generated POSCAR-{number} files. This will require appropriate INCAR, KPOINTS, and POTCAR files. An example INCAR is as follows:
SYSTEM  = "Si"
ISTART = 0          # no initial charges
ICHARG = 2          # superposition method to construct charge density 
PREC = Accurate     # accurate precision
IBRION = -1         # no update, no relaxation
ENCUT = 2*245.345   # 2*ENMAX from POTCAR
EDIFF = 1.0e-07     # more precision to calculate forces
NSW = 0             # no relaxation steps
ISMEAR = 1          # method of Methfessel-Paxton order 1
SIGMA = 0.01        # "width of smearing"
ISYM = 0            # symmetry off
LREAL = .FALSE.     # projection done in reciprocal space 
LWAVE = .FALSE.     # generate WAVECAR
LCHARG = .FALSE.    # generate CHGCAR
NCORE = 4           # number of cores used
Notice that the structures are not relaxed in this step. The KPOINT mesh may be relatively small, in the provided example a Gamma mesh of 6 6 6 is used. 
Copy each POSCAR-{number} into a disp-00{number} directory along with INCAR, KPOINTS, and POTCAR (Appendix 1.2). See (reference) for example bash scripts to automate the process of relocating and submitting these input files. In order to run .sh files, the permissions must be changed using the chmod command.
% chmod +x ./<filename.sh>
Once the calculation has completed, create FORCE_SETS using phonopy. Alter the numbers in the curly braces to reflect the lowest and highest number disp-00{number} directories.
% phonopy -f disp-{0001..0012}/vasprun.xml
Post-process
The following commands are used to generate plottable data as well as phonopy-generated plots. The -s tag will save each plot as a pdf. Configuration files are useful for this process. Below are two examples of configuration files.
Mesh.conf
ATOM_NAME = Si
DIM = 2 2 2
MP = 8 8 8
Band.conf
ATOM_NAME = Si
DIM = 2 2 2
PRIMITIVE_AXIS = AUTO
BAND =    	0.0 	0.0 	0.0     
0.5 	0.0 	0.5     
0.625 0.25 0.625,      
0.375 0.375 0.75        
0.0 	0.0 	0.0     
0.5 	0.5 	0.5     
0.5 	0.25 	0.75        
0.5 	0.0 	0.5
BAND_LABELS = $\Gamma$ X U|K $\Gamma$ L W X
BAND_POINTS = 101 
Mesh.conf is used to generate the Phonon Density of States (DOS) and Thermal Properties data.
Phonon DOS:
% phonopy -p -s mesh.conf
Thermal Properties:
% phonopy -p -s -t mesh.conf
Band.conf is used to generate the Phonon Band Structure:
% phonopy -p -s band.conf
It is recommended to plot this data in Python, see (reference) for an example of plot code. 
