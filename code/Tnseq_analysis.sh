#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 02:00:00
#SBATCH -J Tnseq-analysis
#SBATCH --mail-type=ALL

#SBATCH --output=Tnseq-analysis.out

# Load modules
module load cutadapt/5.0-GCCcore-13.3.0

# Paths
OUT=/home/marinky/Genome-Analysis-Project-VT2026/results/Tn-seq

# Create condition folders
mkdir -p $OUT/BHI
mkdir -p $OUT/HSerum
mkdir -p $OUT/Serum

# Process reads
for f in /home/marinky/Genome_Analysis/1_Zhang_2017/transcriptomics_data/Tn-Seq_*/*.fastq.gz
do
    base=$(basename $f .fastq.gz)


    # Trim the 30‑bp transposon end
    cutadapt \
        -g AACAGGTTGGATGATAAGTCCCCGGTCTTC \
        -O 10 \
        -o $OUT/${base}_trimmed.fastq.gz \
        $f

    #Trim the nfirst 6 nt
    cutadapt \
        -u 6 \
        -o $OUT/${base}_trimmed6.fastq.gz \
        $OUT/${base}_trimmed.fastq.gz

    #Keep only reads ≥ 16 nt
    cutadapt \
        -m 16 \
        -o $OUT/${base}_final.fastq.gz \
        $OUT/${base}_trimmed6.fastq.gz

    #Sort into correct folder based on sample ID
    if [[ $base == *"ERR1801012"* || $base == *"ERR1801013"* || $base == *"ERR1801014"* ]]; then
        mv $OUT/${base}_final.fastq.gz $OUT/BHI/
    elif [[ $base == *"ERR1801009"* || $base == *"ERR1801010"* || $base == *"ERR1801011"* ]]; then
        mv $OUT/${base}_final.fastq.gz $OUT/HSerum/
    elif [[ $base == *"ERR1801006"* || $base == *"ERR1801007"* || $base == *"ERR1801008"* ]]; then
        mv $OUT/${base}_final.fastq.gz $OUT/Serum/
    else
        echo "Sample $base does not match any known condition!"
    fi

done

