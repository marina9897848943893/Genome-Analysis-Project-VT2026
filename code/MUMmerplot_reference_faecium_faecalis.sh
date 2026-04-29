#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 01:00:00
#SBATCH -J MUMmerplot_reference_faecium_faecalis
#SBATCH --mail-type=ALL

#SBATCH --output=MUMmerplot_reference_faecium_faecalis.out

# Load modules
module load MUMmer/4.0.1-GCCcore-13.3.0

# Unzip E. faecium reference genome
gunzip /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/E_faecium/GCF_001750885.1_ASM175088v1_genomic.fna.gz

# MUMmerplot to compare genomes
nucmer --maxmatch --prefix=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_genome/reference_faecium_vs_faecalis \
/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/E_faecalis/GCF_000393015.1_Ente_faec_T5_V1_genomic.fna \
/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/E_faecium/GCF_001750885.1_ASM175088v1_genomic.fna

# relaxed filter
delta-filter -i 70 -l 1000 \
/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_genome/reference_faecium_vs_faecalis.delta \
> /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_genome/reference_faecium_vs_faecalis.relaxed.delta

mummerplot --png --layout \
--prefix=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_genome/reference_faecium_vs_faecalis_relaxed \
/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_genome/reference_faecium_vs_faecalis.relaxed.delta


# 1-to-1 matches
delta-filter -1 \
/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_genome/reference_faecium_vs_faecalis.delta \
> /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_genome/reference_faecium_vs_faecalis.1to1.delta

mummerplot --png --layout \
--prefix=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_genome/reference_faecium_vs_faecalis_1to1 \
/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_genome/reference_faecium_vs_faecalis.1to1.delta
