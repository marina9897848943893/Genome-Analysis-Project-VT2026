#!/bin/bash -l
 
#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 1
#SBATCH -t 00:30:00 
#SBATCH -J Quast_PacBio
#SBATCH --mail-type=ALL 

#SBATCH --output=Quast_PacBio.out

# Load modules 
module load QUAST/5.3.0-gfbf-2024a

# Quast assembly evaluation on PacBio reads
python /sw/arch/eb/software/QUAST/5.3.0-gfbf-2024a/bin/quast.py /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio/E.faeciumE745.contigs.fasta \
	-o /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Quast-evaluation-PacBio
