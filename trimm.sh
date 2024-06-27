#!/bin/bash
#SBATCH --partition=cas
#SBATCH --job-name=Trimfastq
#SBATCH --output=/data/busch/stisinai/log_folder/out/trimmrd2.out
#SBATCH --error=/data/busch/stisinai/log_folder/err/trimmrd2.err
#SBATCH --workdir=/data/busch/stisinai
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=50G
#SBATCH --time=10:00:00
#SBATCH --mail-type=ALL     
#SBATCH --mail-user=shelby.tisinai@wsu.edu

module load fastqc/
module load cutadapt/
module load python/2.7.10


trimg="/data/busch/stisinai/programs/TrimGalore-0.6.6/trim_galore"
pw_data="/data/busch/ccdata"
OUTDIR="/data/busch/stisinai/Ccordifolia/dna/TrimG/round2"

for i in `cat /data/busch/stisinai/Ccordifolia/dna/round2`; do
$trimg $pw_data/$i/$i*_1.fq.gz $pw_data/$i/$i*_2.fq.gz --fastqc --paired --illumina --gzip --trim-n --output_dir $OUTDIR --fastqc_args "--nogroup --outdir $OUTDIR" --quality 28
done
