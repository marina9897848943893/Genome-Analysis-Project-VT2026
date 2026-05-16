#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 10:00:00
#SBATCH -J Htseq-Tnseq
#SBATCH --mail-type=ALL

#SBATCH --output=Htseq-Tnseq.out

# Load modules
module load HTSeq/2.1.2-gfbf-2024a

# Paths
OUTDIR_BHI=/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/BHI

OUTDIR_HSerum=/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/HSerum

OUTDIR_Serum=/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/Serum

BAMDIR=/proj/uppmax2026-1-61/nobackup/Marina2/SAM_files

GFF=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Prokka-annotation-PacBio/Prokka_Annotation_PacBio_noFasta.gff

# HTSeq on BHI BAM files

for SAMPLE in ERR1801012 ERR1801013 ERR1801014
do
    htseq-count -f bam -r pos -s no -t CDS -i locus_tag \
    $BAMDIR/${SAMPLE}.sorted.bam $GFF > $OUTDIR_BHI/${SAMPLE}_counts.txt
done

# HTSeq on HSerum BAM files

for SAMPLE in ERR1801009 ERR1801010 ERR1801011
do
    htseq-count -f bam -r pos -s no -t CDS -i locus_tag \
    $BAMDIR/${SAMPLE}.sorted.bam $GFF > $OUTDIR_HSerum/${SAMPLE}_counts.txt
done

# HTSeq on Serum BAM files

for SAMPLE in ERR1801006 ERR1801007 ERR1801008
do
    htseq-count -f bam -r pos -s no -t CDS -i locus_tag \
    $BAMDIR/${SAMPLE}.sorted.bam $GFF > $OUTDIR_Serum/${SAMPLE}_counts.txt
done
