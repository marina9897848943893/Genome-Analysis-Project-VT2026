#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:15:00
#SBATCH -J FastQC-RNA-BH-Seru-preprocessed
#SBATCH --mail-type=ALL

#SBATCH --output=FastQC-RNA-BH-Seru-preprocessed.out

# Load modules
module load FastQC/0.12.1-Java-17

# FastQC on trimmed BH reads
TRIM_DIR=/proj/uppmax2026-1-61/nobackup/Marina2/Trimmed
OUT_BH=/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/QC_Trim_BH
OUT_SERUM=/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/QC_Trim_Serum

for SAMPLE in ERR1797972 ERR1797973 ERR1797974
do
    fastqc \
        ${TRIM_DIR}/${SAMPLE}_1.trim.paired.fq.gz \
        ${TRIM_DIR}/${SAMPLE}_2.trim.paired.fq.gz \
        --outdir "$OUT_BH"
done

# FastQC on trimmed Serum reads
for SAMPLE in ERR1797969 ERR1797970 ERR1797971
do
    fastqc \
        ${TRIM_DIR}/${SAMPLE}_1.trim.paired.fq.gz \
        ${TRIM_DIR}/${SAMPLE}_2.trim.paired.fq.gz \
        --outdir "$OUT_SERUM"
done

