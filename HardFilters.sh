#!/bin/bash
#SBATCH --partition=
#SBATCH --job-name=HardFilter
#SBATCH --partition=
#SBATCH --output=
#SBATCH --error=
#SBATCH --nodes=1
#SBATCH --mem=64G
#SBATCH --time=70:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=

module load gatk/4.1.4.1
module load samtools/1.9

#after genotyping the merged gvcf file, apply hard filters. Anything staring with the flag "-filter" is an industry standard flag. The "--genotype-filter-expression/-genotype-filter-name" and "--set-filtered-genotype-to-no-call" are addtional filters used to filter on the format fields (e.g., GT, dp, ect.) of the vcf, instead of the usual "filter" field

gatk VariantFiltration \
	-R path_to_reference_file.fa \
    	-V path_to_input.vcf.gz \
	-O path_to_output.vcf.gz \
	-filter "QD < 2.0" --filter-name "QD2" \
	-filter "QUAL < 30.0" --filter-name "QUAL30" \
	-filter "SOR > 3.0" --filter-name "SOR3" \
	-filter "FS > 60.0" --filter-name "FS60" \
	-filter "MQ < 50.0" --filter-name "MQ50" \
        -filter "MAPQ=255" --filter-name "MQ255" \
        -filter "MQRankSum < -2.5" --filter-name "MQRankSum-2.5" \
        -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
        -filter "ExcessHet > 11" --filter-name "ExcessHet" \
	--genotype-filter-expression "DP < 10" --genotype-filter-name "DP10" \
	--set-filtered-genotype-to-no-call true