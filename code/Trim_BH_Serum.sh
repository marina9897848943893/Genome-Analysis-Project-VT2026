#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 10:00:00
#SBATCH -J Trim-BH-Serum
#SBATCH --mail-type=ALL

#SBATCH --output=Trim-BH-Serum.out

# Load modules
module load Trimmomatic/0.39-Java-17

# Trim on raw BH reads
INPUT_DIR_BH=/home/marinky/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_BH/raw
INPUT_DIR_Serum=/home/marinky/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_Serum/raw
OUTDIR=/proj/uppmax2026-1-61/nobackup/Marina2/Trimmed

for SAMPLE in ERR1797972 ERR1797973 ERR1797974
do
  READ1=${INPUT_DIR_BH}/${SAMPLE}_1.fastq.gz
  READ2=${INPUT_DIR_BH}/${SAMPLE}_2.fastq.gz

  OUT_P1=${OUTDIR}/${SAMPLE}_1.trim.paired.fq.gz
  OUT_U1=${OUTDIR}/${SAMPLE}_1.trim.unpaired.fq.gz
  OUT_P2=${OUTDIR}/${SAMPLE}_2.trim.paired.fq.gz
  OUT_U2=${OUTDIR}/${SAMPLE}_2.trim.unpaired.fq.gz

  trimmomatic PE -threads 1 -phred33 \
    "$READ1" "$READ2" \
    "$OUT_P1" "$OUT_U1" \
    "$OUT_P2" "$OUT_U2" \
    ILLUMINACLIP:/sw/arch/eb/software/Trimmomatic/0.39-Java-17/adapters/TruSeq3-PE.fa:2:30:10 \
    SLIDINGWINDOW:4:15 \
    MINLEN:36
done

# Trim Serum raw reads
for SAMPLE in ERR1797969 ERR1797970 ERR1797971
do
  READ1=${INPUT_DIR_Serum}/${SAMPLE}_1.fastq.gz
  READ2=${INPUT_DIR_Serum}/${SAMPLE}_2.fastq.gz

  OUT_P1=${OUTDIR}/${SAMPLE}_1.trim.paired.fq.gz
  OUT_U1=${OUTDIR}/${SAMPLE}_1.trim.unpaired.fq.gz
  OUT_P2=${OUTDIR}/${SAMPLE}_2.trim.paired.fq.gz
  OUT_U2=${OUTDIR}/${SAMPLE}_2.trim.unpaired.fq.gz

  trimmomatic PE -threads 1 -phred33 \
    "$READ1" "$READ2" \
    "$OUT_P1" "$OUT_U1" \
    "$OUT_P2" "$OUT_U2" \
    ILLUMINACLIP:/sw/arch/eb/software/Trimmomatic/0.39-Java-17/adapters/TruSeq3-PE.fa:2:30:10 \
    SLIDINGWINDOW:4:15 \
    MINLEN:36
done
