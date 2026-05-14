#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 10:00:00
#SBATCH -J Htseq-BH
#SBATCH --mail-type=ALL

#SBATCH --output=Htseq-BH.out

# Load modules
module load HTSeq/2.1.2-gfbf-2024a

# Paths
OUTDIR=/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Htseq-BH

BAMDIR=/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/BAM-BH

GFF=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Prokka-annotation-PacBio/Prokka_Annotation_PacBio_noFasta.gff

# HTSeq on BH BAM files

for SAMPLE in ERR1797972 ERR1797973 ERR1797974
do
    htseq-count -f bam -r pos -s no -t CDS -i locus_tag \
    $BAMDIR/${SAMPLE}.sorted.bam $GFF > $OUTDIR/${SAMPLE}_counts.txt
done
