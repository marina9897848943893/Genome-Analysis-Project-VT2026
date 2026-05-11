#!/bin/bash -l
 
#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 1 
#SBATCH -t 00:15:00 
#SBATCH -J FastQC-RNA-BH-raw 
#SBATCH --mail-type=ALL 

#SBATCH --output=FastQC-RNA-BH-raw.out
 
# Load modules 
module load FastQC/0.12.1-Java-17
 
# FastQC on raw BH reads 
fastqc /home/marinky/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_BH/raw/* \
	--outdir /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/QC_BH_raw
