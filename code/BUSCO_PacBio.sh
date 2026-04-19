#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J BUSCO_PacBio
#SBATCH --mail-type=ALL

#SBATCH --output=BUSCO_PacBio.out

# Load modules
module load BUSCO/5.8.2-gfbf-2024a

# BUSCO evaluation on PacBio reads
busco -i /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio/E.faeciumE745.contigs.fasta \
	-m genome \
	-l bacteria_odb10 \
	-o BUSCO_PacBio \
	--out_path /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/BUSCO-evaluation-PacBio
