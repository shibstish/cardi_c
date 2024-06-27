#!/bin/bash
#SBATCH --job-name=HaploCaller
#SBATCH --partition=  
#SBATCH --mem-per-cpu=40gb           
#SBATCH --mail-type=END,FAIL          
#SBATCH --mail-user=
#SBATCH --ntasks=1                   
#SBATCH --cpus-per-task=1            
#SBATCH --output=
#SBATCH --error=

module load gatk/4.1.4.1
module load samtools/1.9

#After putting read groups on the bam files AND verifying that you have created the dictionary file, push the bam files through HaplotypeCaller, outputting gziped vcfs.

gatk HaplotypeCaller -R path_to_reference.fa -I path_to_bam_file -O path_to_output_vcf.gz -ERC GVCF 
