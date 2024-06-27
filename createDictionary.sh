#!/bin/bash
#SBATCH --job-name=dictionary
#SBATCH --output=
#SBATCH --error=
#SBATCH --workdir=
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=70G
#SBATCH --time=10:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=

module load gatk/4.1.8.1

gatk CreateSequenceDictionary -R path_to_reference_file.fa
