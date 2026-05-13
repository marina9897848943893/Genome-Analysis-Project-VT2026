#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 02:00:00
#SBATCH -J SortBAMs
#SBATCH --mail-type=ALL

#SBATCH --output=SortBAMs.out

# Load modules
module load SAMtools/1.22.1-GCC-13.3.0

# Paths
DIR=/proj/uppmax2026-1-61/nobackup/Marina2/SAM_files

# Sort BAM files
for SAMPLE in ERR1797969 ERR1797970 ERR1797971 ERR1797972 ERR1797973 ERR1797974
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
