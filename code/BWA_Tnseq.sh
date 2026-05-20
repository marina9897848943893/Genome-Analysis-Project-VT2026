#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 05:00:00
#SBATCH -J BWA-Tnseq
#SBATCH --mail-type=ALL

#SBATCH --output=BWA-Tnseq.out

# Load modules
module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# Paths
INPUT_DIR_BHI=/home/marinky/Genome-Analysis-Project-VT2026/results/Tn-seq/BHI

INPUT_DIR_HSerum=/home/marinky/Genome-Analysis-Project-VT2026/results/Tn-seq/HSerum

INPUT_DIR_Serum=/home/marinky/Genome-Analysis-Project-VT2026/results/Tn-seq/Serum

OUTDIR=/proj/uppmax2026-1-61/nobackup/Marina2/SAM_files

REF_GENOME=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio/E.faeciumE745.contigs.fasta

# Index reference genome
bwa index "$REF_GENOME"

# Loop for BHI sequences
for SAMPLE in ERR1801012 ERR1801013 ERR1801014
do
    READ_BHI="${INPUT_DIR_BHI}/trim_${SAMPLE}_pass_final.fastq.gz"


    OUT_SAM="${OUTDIR}/${SAMPLE}.sam"
    OUT_BAM="${OUTDIR}/${SAMPLE}.bam"
    #OUT_SORT_BAM="${OUTDIR}/${SAMPLE}.sorted.bam"

    # BWA on BH trimmed paired sequences
    bwa mem -M "$REF_GENOME" "$READ_BHI" > "$OUT_SAM"

    # Convert SAM to BAM and then sort
    samtools view -bS "$OUT_SAM" -o "$OUT_BAM"
    #samtools sort "$OUT_BAM" -o "$OUT_SORT_BAM"    

    # Index BAM
    #samtools index "$OUT_SORT_BAM"

    # Remove SAM
    #rm "$OUT_SAM"

done

# Loop for HSerum sequences
for SAMPLE in ERR1801009 ERR1801010 ERR1801011
do
    READ_HSerum="${INPUT_DIR_HSerum}/trim_${SAMPLE}_pass_final.fastq.gz"

    OUT_SAM="${OUTDIR}/${SAMPLE}.sam"
    OUT_BAM="${OUTDIR}/${SAMPLE}.bam"
    #OUT_SORT_BAM="${OUTDIR}/${SAMPLE}.sorted.bam"

    # BWA on BH trimmed paired sequences
    bwa mem -M "$REF_GENOME" "$READ_HSerum" > "$OUT_SAM"

    # Convert SAM to BAM and then sort
    samtools view -bS "$OUT_SAM" -o "$OUT_BAM"
    #samtools sort "$OUT_BAM" -o "$OUT_SORT_BAM"

    # Index BAM
    #samtools index "$OUT_SORT_BAM"

    # Remove SAM
    #rm "$OUT_SAM"

done

# Loop for Serum sequences
for SAMPLE in ERR1801006 ERR1801007 ERR1801008
do
    READ_Serum="${INPUT_DIR_Serum}/trim_${SAMPLE}_pass_final.fastq.gz"

    OUT_SAM="${OUTDIR}/${SAMPLE}.sam"
    OUT_BAM="${OUTDIR}/${SAMPLE}.bam"
    #OUT_SORT_BAM="${OUTDIR}/${SAMPLE}.sorted.bam"

    # BWA on BH trimmed paired sequences
    bwa mem -M "$REF_GENOME" "$READ_Serum" > "$OUT_SAM"

    # Convert SAM to BAM and then sort
    samtools view -bS "$OUT_SAM" -o "$OUT_BAM"
    #samtools sort "$OUT_BAM" -o "$OUT_SORT_BAM"

    # Index BAM
    #samtools index "$OUT_SORT_BAM"

    # Remove SAM
    #rm "$OUT_SAM"

done

# Paths
DIR=/proj/uppmax2026-1-61/nobackup/Marina2/SAM_files

# Sort BAM files
for SAMPLE in ERR1801006 ERR1801007 ERR1801008 ERR1801009 ERR1801010 ERR1801011 ERR1801012 ERR1801013 ERR1801014
do
    
    BAM="${DIR}/${SAMPLE}.bam"
    SORT_BAM="${DIR}/${SAMPLE}.sorted.bam"

    # Sort BAM files
    samtools sort "$BAM" -o "$SORT_BAM"

    # Index BAM
    samtools index "$SORT_BAM"

    # Remove SAM
    #rm "$OUT_SAM"

done

#cp /proj/uppmax2026-1-61/nobackup/Marina2/SAM_files/ERR1801006.sorted.* /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/Serum
#cp /proj/uppmax2026-1-61/nobackup/Marina2/SAM_files/ERR1801007.sorted.* /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/Serum
#cp /proj/uppmax2026-1-61/nobackup/Marina2/SAM_files/ERR1801008.sorted.* /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/Serum


#cp /proj/uppmax2026-1-61/nobackup/Marina2/SAM_files/ERR1801009.sorted.* /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/HSerum
#cp /proj/uppmax2026-1-61/nobackup/Marina2/SAM_files/ERR1801010.sorted.* /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/HSerum
#cp /proj/uppmax2026-1-61/nobackup/Marina2/SAM_files/ERR1801011.sorted.* /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/HSerum


#cp /proj/uppmax2026-1-61/nobackup/Marina2/SAM_files/ERR1801012.sorted.* /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/BHI
#cp /proj/uppmax2026-1-61/nobackup/Marina2/SAM_files/ERR1801013.sorted.* /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/BHI
#cp /proj/uppmax2026-1-61/nobackup/Marina2/SAM_files/ERR1801014.sorted.* /home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/BHI
