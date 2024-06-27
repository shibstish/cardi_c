#!/bin/bash
#SBATCH --partition=
#SBATCH --job-name=GenotypeGVCF
#SBATCH --output=
#SBATCH --error=
#SBATCH --workdir=
#SBATCH --nodes=1
#SBATCH --mem=64G
#SBATCH --time=70:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=

module load gatk/4.1.4.1
module load samtools/1.9

#This script is to be used after merging the haplotyped sample vcfs together to form one vcf for each population
#genotype the population

gatk GenotypeGVCFs \
   -R path_to_reference \
   -V path_to_input.vcf.gz \
   -O path_to_output.vcf.gz
