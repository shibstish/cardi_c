#!/bin/bash
#SBATCH --partition=
#SBATCH --job-name=FitCoal
#SBATCH --output=
#SBATCH --error=
#SBATCH --workdir=
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=280G
#SBATCH --time=10:00:00
#SBATCH --mail-type=END,FAIL     
#SBATCH --mail-user=

module load java/oracle_1.8.0_92

fitcoal="[path-to-jar-file]"

java -cp $fitcoal FitCoal.calculate.SinglePopDecoder -table [path-to-table-output-folder] -input [path-to-infile] -output [path-to-outfile] -mutationRate 0.00000000695 -generationTime 5 -genomeLength 225000  -noIG -noID  -timeUpperBound 3
