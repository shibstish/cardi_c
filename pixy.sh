#!/bin/bash
#SBATCH --partition=cas
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time 24:00:00
#SBATCH --job-name pixy
#SBATCH --mem=20GB              ### More memory
#SBATCH --output pixy.out
#SBATCH --error pixy.err

module load miniconda3/3.12
source activate pixy
pixy --stats fst dxy \
--vcf /data/lab/busch/stisinai/Ccordifolia/dna/VCF/filtered/plink/Ccordi.maf5v2.vcf.gz \
--populations /data/lab/busch/stisinai/Ccordifolia/dna/VCF/filtered/plink/pops.txt \
--window_size 10000000 \
--bypass_invariant_check 'yes' \
