#!/bin/bash -l
 
#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 4
#SBATCH -t 03:30:00 
#SBATCH -J Canu_PacBio 
#SBATCH --mail-type=ALL 

#SBATCH --output=Canu_PacBio.out

# Load modules
module load canu/2.3-GCCcore-13.3.0-Java-17

# Canu assembly on PacBio reads
canu \
	-p E.faeciumE745 \
	-d /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio \
	genomeSize=3.2m \
	-raw \
	-pacbio /proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/PacBio/*.fastq.gz \
	useGrid=false \
	bamOutput=false
