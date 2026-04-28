#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 10:00:00
#SBATCH -J BLAST_separated_plasmids
#SBATCH --mail-type=ALL
#SBATCH --output=BLAST_separated_plasmids.out

# Load BLAST
module load BLAST+/2.17.0-GCC-13.3.0

# Move to working directory
cd /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/BLAST-plasmids-PacBio/

# Split contigs
awk '
/^>/ {
    name = substr($1,2)
    file = name ".fasta"
}
{ print > file }
' ../Canu-assembly-PacBio/E.faeciumE745.contigs.fasta

echo "Fasta file split into individual contigs."

# Find largest contig to remove
largest=$(for f in *.fasta; do
    len=$(grep -v "^>" "$f" | tr -d '\n' | wc -c)
    echo "$len $f"
done | sort -nr | head -n1 | awk '{print $2}')

echo "Largest contig (chromosome): $largest"


rm "$largest"

# BLAST on separate fasta to identify each plasmid
for file in *.fasta
do
    base=$(basename "$file" .fasta)

    blastn \
        -query "$file" \
        -db /sw/data/blast_databases/nt \
        -out "${base}_blast.txt" \
        -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore sscinames stitle" \
        -num_threads 2
done

echo "BLAST completed for all plasmid candidates."
