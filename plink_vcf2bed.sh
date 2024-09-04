#!/bin/bash
#SBATCH --partition=
#SBATCH --job-name=plink
#SBATCH --error=
#SBATCH --output=
#SBATCH --mail-user=
#SBATCH --mail-type=END,FAIL

module load plink/1.9

plink --vcf [path-to-vcf] --allow-extra-chr --indep 50 5 2 #this creates files "plink.prune.in" and "plink.prune.out"

plink --vcf [path_to_VCF_file]/Ccordifolia.f.vcf --allow-extra-chr --maf 0.05 --extract plink.prune.in --geno 0 --make-bed --out /[path-to-outfile]
