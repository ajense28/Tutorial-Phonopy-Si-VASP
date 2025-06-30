#!/bin/bash
# Author: Alison Jensen # Date: 6/12/25
# filename: submit.sh
# uses submit script (ie submit_vasp) in ~/bin/ to submit all <TYPE> job directories in the run directory

args=("$@")
if ! ((${#args[@]}==5)); then
  echo -e "Error: Need 5 arguments --- suggested usage\nsubmit.sh <KPTS/ENCUT/PHONON/ALL> <submit-script> <num-nodes> <num-tasks-per-node> <job-name>"
  exit 64
fi
# initialize
dir=$(pwd)
case "${args[0]}" in
    [Kk]*)
    TYPE="K*/"
    ;;
    [Ee]*)
    TYPE="E*/"
    ;;
    [Pp]* | *)
    TYPE="d*/"
    ;;
    [Aa]* | *)
    TYPE="*/"
    ;;
esac
NODES=${args[2]}
TASKS=${args[3]}
JOB_NAME=${args[4]}
i=1
# submit scripts
for d in $TYPE; do
    cd "$d"
    ${args[1]} $NODES $TASKS "$JOB_NAME"_$i
    i=$((i+1))
    cd $dir
done
