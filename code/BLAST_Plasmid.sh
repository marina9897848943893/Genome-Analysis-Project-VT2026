#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 05:00:00
#SBATCH -J BLAST_Plasmid
#SBATCH --mail-type=ALL

#SBATCH --output=BLAST_Plasmid.out

# Load modules
module load BLAST+/2.17.0-GCC-13.3.0

# BLAST on contigs fasta sequence to identify the plasmids
blastn \
	-query /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio/E.faeciumE745.contigs.fasta \
	-db /sw/data/blast_databases/nt \
	-out /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/BLAST-plasmids-PacBio/BLAST_plasmids_results.txt
