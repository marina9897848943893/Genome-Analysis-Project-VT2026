#!/bin/bash -l
 
#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 1 
#SBATCH -t 00:15:00 
#SBATCH -J FastQC-Illumina-raw 
#SBATCH --mail-type=ALL 

#SBATCH --output=FastQC-Illumina-raw.out
 
# Load modules 
module load FastQC/0.12.1-Java-17
 
# FastQC on Illumina reads 
fastqc /proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/* \
	--outdir /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/Illumina-Nanopore/QC-Illumina_Nanopore 
