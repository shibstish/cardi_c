#!/bin/bash
#SBATCH --job-name=admixture
#SBATCH --partition=
#SBATCH --error=
#SBATCH --output=
#SBATCH --mem=128G
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=

module load vcftools/0.1.16
admixture="[path-to-program]"


for K in 1 2 3 4 5 6; do
  $admixture -s 12345 -C 0.0001 --cv [path-to-bed-infile] $K |tee [path-to-outfile] ;

done
