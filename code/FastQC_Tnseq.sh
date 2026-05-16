#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 01:00:00
#SBATCH -J FastQC-Tnseq
#SBATCH --mail-type=ALL

#SBATCH --output=FastQC-Tnseq.out

# Load modules
module load FastQC/0.12.1-Java-17

# FastQC on BHI 
fastqc /home/marinky/Genome_Analysis/1_Zhang_2017/transcriptomics_data/Tn-Seq_BHI/* \
        --outdir /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/BHI

# FastQC on HSerum
fastqc /home/marinky/Genome_Analysis/1_Zhang_2017/transcriptomics_data/Tn-Seq_HSerum/* \
        --outdir /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/HSerum

# FastQC on Serum
fastqc /home/marinky/Genome_Analysis/1_Zhang_2017/transcriptomics_data/Tn-Seq_Serum/* \
        --outdir /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/Serum
