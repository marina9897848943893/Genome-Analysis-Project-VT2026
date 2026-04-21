#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J BLAST_faecium_faecalis
#SBATCH --mail-type=ALL

#SBATCH --output=BLAST_faecium_faecalis.out

# Load modules
module load BLAST+/2.17.0-GCC-13.3.0

# Unzip E. faecalis reference genome
cd /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/E_faecalis
gunzip -f GCF_000393015.1_Ente_faec_T5_V1_genomic.fna.gz

# Create a BLAST database of E.faecalis
makeblastdb \
    -in GCF_000393015.1_Ente_faec_T5_V1_genomic.fna \
    -dbtype nucl \
    -out E_faecalis_db

# BLAST on contigs fasta sequence to identify the plasmids
cd /home/marinky/Genome-Analysis-Project-VT2026/code

blastn \
        -query /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio/E.faeciumE745.contigs.fasta \
        -db /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/E_faecalis/E_faecalis_db \
        -out /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/BLAST-synteny/BLAST_faecium_faecalis_results.txt \
	-outfmt 6 \
	-num_threads 2
