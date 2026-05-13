#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 10:00:00
#SBATCH -J Htseq-Serum
#SBATCH --mail-type=ALL

#SBATCH --output=Htseq-Serum.out

# Load modules
module load HTSeq/2.1.2-gfbf-2024a

# Paths
OUTDIR=/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Htseq-Serum

BAMDIR=/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/BAM-Serum

GFF=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Prokka-annotation-PacBio/Prokka_Annotation_PacBio_noFasta.gff

# HTSeq on Serum BAM files

for SAMPLE in ERR1797969 ERR1797970 ERR1797971
do
    htseq-count -f bam -r pos -s no -t gene -i locus_tag \
    $BAMDIR/${SAMPLE}.sorted.bam $GFF > $OUTDIR/${SAMPLE}_counts.txt
done
