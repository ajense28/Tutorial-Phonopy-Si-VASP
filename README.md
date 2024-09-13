# Phonopy VASP Method
Roughly following [this tutorial]([url](https://phonopy.github.io/phonopy/vasp.html)) on the Phonopy Github page and [this tutorial]([url](https://www.youtube.com/watch?v=FX7WjL074g4)) on youtube (_Phonon Calculations in Materials Science using VASP & phonopy by Rasoul Khaledi_).

## Relaxation
Find or create a POSCAR for the desired structure. [Materials Project]([url](https://next-gen.materialsproject.org/materials)) is useful for this. Relax the POSCAR file using VASP. This will require appropriate INCAR, KPOINTS, and POTCAR files (examples are labelled with "relaxation"). The relaxed output CONTCAR will be used as the input POSCAR in future steps.
## Pre-process
To choose the supercell, refer to the relaxed POSCAR. A 2 2 2 supercell is typical, but a noncubic unit cell might need more or fewer cells along a certain axis. For example, the Si unit cell is cubic and a 2 2 2 supercell is sufficient. A supercell as large as 4 4 4 can be used for VASP, but is not recommended as it increases runtime exponentially.
To generate the 2 2 2 supercell with no symmetry and automatic primitive axes, replace <POSCAR> with the name of the POSCAR file, ie POSCAR or POSCAR-unitcell:
`% phonopy -d --dim 2 2 2 --nosym --pa auto -c <POSCAR> `
This will generate a number of POSCAR-_{number}_ files to be used in the next step.
## Force Calculation
Calculations using the finite displacement method are completed through force calculations on the generated POSCAR-{number} files. This will require appropriate INCAR, KPOINTS, and POTCAR files. The example INCAR file for Silicon is labelled with "forces".
Notice that the structures are not relaxed in this step. The KPOINT mesh may be relatively small, in the provided example a Gamma mesh of 6 6 6 is used. 
Copy each POSCAR-{number} into a disp-00{number} directory along with INCAR, KPOINTS, and POTCAR (Appendix 1.2). See (reference) for example bash scripts to automate the process of relocating and submitting these input files. In order to run .sh files, the permissions must be changed using the chmod command.
`% chmod +x ./<filename.sh>`
Once the calculation has completed, create FORCE_SETS using phonopy. Alter the numbers in the curly braces to reflect the lowest and highest number disp-00{number} directories.
`% phonopy -f disp-{0001..0012}/vasprun.xml`
## Post-process
The following commands are used to generate plottable data as well as phonopy-generated plots. The -s tag will save each plot as a pdf. Configuration files are useful for this process. Mesh.conf is used to generate the Phonon Density of States (DOS) and Thermal Properties data.
### Phonon DOS:
`% phonopy -p -s mesh.conf`
### Thermal Properties:
`% phonopy -p -s -t mesh.conf`
### Band Structure:
Band.conf is used to generate the Phonon Band Structure.
`% phonopy -p -s band.conf`

It is recommended to plot this data in Python, see the Jupyter Notebooks file provided. 
## Phonopy Setup (ARCC HPC)
The Python module Phonopy has to be installed manually onto the arcc using conda. [This page]([url](https://phonopy.github.io/phonopy/install.html)) on the phonopy github is useful, as well as [this page]([url](https://arccwiki.atlassian.net/wiki/spaces/DOCUMENTAT/pages/7504145/Miniconda#Install-Packages-into-a-Miniconda-Environment-in-Your-Home-Directory)) on the arcc wiki. To activate the phonopy conda environment, enter the following and replace <phonopy-env> with the name of the conda phonopy environment:
`% module load miniconda3/23.11.0
% conda activate _<phonopy-env>_`
