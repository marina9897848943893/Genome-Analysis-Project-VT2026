#!/bin/bash -l
 
#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 1
#SBATCH -t 00:05:00 
#SBATCH -J SPAdes_Illumina-Nanopore 
#SBATCH --mail-type=ALL 

#SBATCH --output=SPAdes_Illumina-Nanopore.out

# Load modules
module load SPAdes/4.2.0-GCC-13.3.0

# SPAdes assembly on Illumina and Nanopore reads
spades.py --pe1-1 /home/marinky/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/*_1_clean.fq.gz \
	--pe1-2 /home/marinky/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/*_2_clean.fq.gz \
	--nanopore /home/marinky/Genome_Analysis/1_Zhang_2017/genomics_data/Nanopore/* \
	-o /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/Illumina-Nanopore/SPAdes-assembly-Illumina_Nanopore
	
