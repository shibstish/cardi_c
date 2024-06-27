#!/bin/bash
#SBATCH --partition=cas
#SBATCH --job-name=bwasam
#SBATCH --output=/data/busch/stisinai/log_folder/out/bwasam.out
#SBATCH --error=/data/busch/stisinai/log_folder/err/bwasam.err
#SBATCH --workdir=/data/busch/stisinai
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=72:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=shelby.tisinai@wsu.edu

module load bwa/0.7.17
module load samtools/1.3.1

#for i in `cat /data/busch/stisinai/Ccordifolia/dna/round2`; do
bwa mem /data/busch/stisinai/ref_genome/cHirsuta/chi_V1.fa /data/busch/stisinai/Ccordifolia/dna/TrimG/ECT/ECT1_CKDN220031289-1A_HY5MFDSX3_L1_1_val_1.fq.gz /data/busch/stisinai/Ccordifolia/dna/TrimG/ECT/ECT1_CKDN220031289-1A_HY5MFDSX3_L1_1_val_1.fq.gz | samtools view -b -S | samtools sort -o /data/busch/stisinai/Ccordifolia/dna/BAMs/round1/ECT1.bam
#done
