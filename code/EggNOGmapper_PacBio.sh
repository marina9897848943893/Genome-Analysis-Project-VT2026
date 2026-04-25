#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 14:00:00
#SBATCH -J EggNOGmapper_PacBio
#SBATCH --mail-type=ALL

#SBATCH --output=EggNOGmapper_PacBio.out

# Load modules
module load eggnog-mapper/2.1.13-gfbf-2024a

# EggNOGmapper annotation on PacBio reads
emapper.py \
	--data_dir /home/marinky/Genome-Analysis-Project-VT2026/code/resources/eggnog-mapper/rackham \
	--itype genome \
	--genepred prodigal \
	-i /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio/E.faeciumE745.contigs.fasta \
	--output_dir /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/EggNOGmapper-annotation-PacBio \
	-o EggNOGmapper_PacBio \
	--cpu 2
