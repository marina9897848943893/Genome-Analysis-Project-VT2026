#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J Prokka_ref
#SBATCH --mail-type=ALL
#SBATCH --output=Prokka_ref.out

# Load modules
module load prokka/1.14.5-gompi-2024a

# Prokka annotation on reference genome
prokka /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/E_faecium/GCF_001750885.1_ASM175088v1_genomic.fna \
       --outdir /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/E_faecium/Prokka-annotation \
       --prefix Annotation_reference \
       --genus Enterococcus \
       --species faecium \
       --strain E745
