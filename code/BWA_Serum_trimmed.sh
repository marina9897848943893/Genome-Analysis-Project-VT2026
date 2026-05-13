#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 05:00:00
#SBATCH -J BWA-Serum-trimmed
#SBATCH --mail-type=ALL

#SBATCH --output=BWA-Serum-trimmed.out

# Load modules
module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# Paths
INPUT_DIR=/home/marinky/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_Serum/trimmed

OUTDIR=/proj/uppmax2026-1-61/nobackup/Marina2/SAM_files

REF_GENOME=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio/E.faeciumE745.contigs.fasta

# Index reference genome
bwa index "$REF_GENOME"

# Loop for all paired sequences
for SAMPLE in ERR1797969 ERR1797970 ERR1797971
do
    READ1="${INPUT_DIR}/trim_paired_${SAMPLE}_pass_1.fastq.gz"
    READ2="${INPUT_DIR}/trim_paired_${SAMPLE}_pass_2.fastq.gz"

    OUT_SAM="${OUTDIR}/${SAMPLE}.sam"
    OUT_BAM="${OUTDIR}/${SAMPLE}.bam"
    #OUT_SORT_BAM="${OUTDIR}/${SAMPLE}.sorted.bam"

    # BWA on Serum trimmed paired sequences
    bwa mem -M "$REF_GENOME" "$READ1" "$READ2" > "$OUT_SAM"

    # Convert SAM to BAM and then sort
    samtools view -bS "$OUT_SAM" -o "$OUT_BAM"
    #samtools sort "$OUT_BAM" -o "$OUT_SORT_BAM"

    # Index BAM
    #samtools index "$OUT_SORT_BAM"

    # Remove SAM
    #rm "$OUT_SAM"

done
