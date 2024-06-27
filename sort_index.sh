#!/bin/bash
#SBATCH --job-name=sorting
#SBATCH --partition=cas
#SBATCH --output=/data/busch/stisinai/log_folder/out/sort.out
#SBATCH --error=/data/busch/stisinai/log_folder/err/sort.err
#SBATCH --nodes=1
#SBATCH --mem=50G
#SBATCH --time=10:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=shelby.tisinai@wsu.edu

module load samtools/1.9

samtools sort /data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/MCC1_marked.bam -o /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/MCC1.sorted.bam
samtools index /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/MCC1.sorted.bam

samtools sort /data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/MCC3_marked.bam -o /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/MCC3.sorted.bam
samtools index /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/MCC3.sorted.bam

samtools sort /data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/MCC5_marked.bam -o /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/MCC5.sorted.bam
samtools index /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/MCC5.sorted.bam

samtools sort /data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/PCCL2_marked.bam -o /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/PCCL2.sorted.bam
samtools index /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/PCCL2.sorted.bam

samtools sort /data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/PCCL11_marked.bam -o /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/PCCL11.sorted.bam
samtools index /data/busch/stisinai/Ccordifolia/dna/BAMs/sorted/PCCL11.sorted.bam
