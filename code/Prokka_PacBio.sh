#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J Prokka_PacBio
#SBATCH --mail-type=ALL

#SBATCH --output=Prokka_PacBio.out

# Load modules
module load prokka/1.14.5-gompi-2024a

# Prokka annotation on PacBio reads
prokka /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio/E.faeciumE745.contigs.fasta \
       --outdir /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Prokka-annotation-PacBio/Prokka_PacBio \
       --prefix Annotation_PacBio \
       --genus Enterococcus \
       --species faecium \
       --strain E745 
