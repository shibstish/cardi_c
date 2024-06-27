#!/bin/bash
#SBATCH --partition=cas          ### Partition (like a queue in PBS)
#SBATCH --job-name=picCcord1           ### Job Name
#SBATCH --output=/data/busch/stisinai/log_folder/out/picCcord1.out          ### File in which to store job output
#SBATCH --error=/data/busch/stisinai/log_folder/err/picCcord1.err           ### File in which to store job error messages
#SBATCH --time=7-00:00:00           ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                   ### Node count required for the job
#SBATCH --mem=70G
#SBATCH --ntasks-per-node=1
#SBATCH --mail-type=ALL        ### Notifications for job done & fail
#SBATCH --mail-user=shelby.tisinai@wsu.edu  ### Send-to address

module load java/oracle_1.8.0_92
module load picard/2.21.4

picard MarkDuplicates \
I=/data/busch/stisinai/Ccordifolia/dna/BAMs/merged/ECT10_merged.bam \
M=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/ECT10_metrics.txt \
O=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/ECT10_marked.bam \
REMOVE_DUPLICATES=true \
VALIDATION_STRINGENCY=SILENT

picard MarkDuplicates \
I=/data/busch/stisinai/Ccordifolia/dna/BAMs/merged/ECT9_merged.bam \
M=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/ECT9_metrics.txt \
O=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/ECT9_marked.bam \
REMOVE_DUPLICATES=true \
VALIDATION_STRINGENCY=SILENT

picard MarkDuplicates \
I=/data/busch/stisinai/Ccordifolia/dna/BAMs/merged/FCT8_merged.bam \
M=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/FCT8_metrics.txt \
O=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/FCT8_marked.bam \
REMOVE_DUPLICATES=true \
VALIDATION_STRINGENCY=SILENT

picard MarkDuplicates \
I=/data/busch/stisinai/Ccordifolia/dna/BAMs/merged/GCT2_merged.bam \
M=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/GCT2_metrics.txt \
O=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/GCT2_marked.bam \
REMOVE_DUPLICATES=true \
VALIDATION_STRINGENCY=SILENT

picard MarkDuplicates \
I=/data/busch/stisinai/Ccordifolia/dna/BAMs/merged/MCC7_merged.bam \
M=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/MCC7_metrics.txt \
O=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/MCC7_marked.bam \
REMOVE_DUPLICATES=true \
VALIDATION_STRINGENCY=SILENT

picard MarkDuplicates \
I=/data/busch/stisinai/Ccordifolia/dna/BAMs/merged/PCCL3_merged.bam \
M=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/PCCL3_metrics.txt \
O=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/PCCL3_marked.bam \
REMOVE_DUPLICATES=true \
VALIDATION_STRINGENCY=SILENT

picard MarkDuplicates \
I=/data/busch/stisinai/Ccordifolia/dna/BAMs/merged/PCCL5_merged.bam \
M=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/PCCL5_metrics.txt \
O=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/PCCL5_marked.bam \
REMOVE_DUPLICATES=true \
VALIDATION_STRINGENCY=SILENT

picard MarkDuplicates \
I=/data/busch/stisinai/Ccordifolia/dna/BAMs/merged/PCCL6_merged.bam \
M=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/PCCL6_metrics.txt \
O=/data/busch/stisinai/Ccordifolia/dna/BAMs/new_bams/PCCL6_marked.bam \
REMOVE_DUPLICATES=true \
VALIDATION_STRINGENCY=SILENT
