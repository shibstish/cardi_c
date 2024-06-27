#!/bin/bash
#SBATCH --partition=
#SBATCH --job-name=combineGVCF
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

#after running GATK HaplotypeCaller for each single-sample GVCF for each sample, merge the sample vcfs together to form one vcf for each population
#combining samples per population

gatk CombineGVCFs \
   -R path_to_reference \
   --variant path_to_variant_file1 \
   --variant path_to_variant_file2 \
   --variant path_to_variant_file3 \
   --variant path_to_variant_file4 \
   --variant path_to_variant_file5 \
   --variant path_to_variant_file6 \
   -O path_to_output_file 
