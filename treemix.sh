#!/bin/bash
#SBATCH --job-name=TM6
#SBATCH --partition=
#SBATCH --error=
#SBATCH --output=
#SBATCH --mem=128GB
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=

module load treemix/1.13
for i in `seq 6`
do
 treemix -i [path-to-infile] -m $i -root outgroup -o [path-to-outfile__$I] -bootstrap -k 500 -noss > treemix6_${i}_log
done

