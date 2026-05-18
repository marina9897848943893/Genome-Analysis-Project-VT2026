#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 01:00:00
#SBATCH -J MUMmerplot_reference_assembled
#SBATCH --mail-type=ALL
#SBATCH --output=MUMmerplot_reference_assembled.out

# Load modules
module load MUMmer/4.0.1-GCCcore-13.3.0

# Paths
REF_ASSEMBLED=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Canu-assembly-PacBio/E.faeciumE745.contigs.fasta
QUERY_NCBI=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/E_faecium/GCF_001750885.1_ASM175088v1_genomic.fna
OUTDIR=/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/MUMmerplot-synteny/reference_assembled

mkdir -p $OUTDIR

# Assembled genome vs reference

nucmer --maxmatch --prefix=$OUTDIR/assembled_vs_reference \
$REF_ASSEMBLED \
$QUERY_NCBI


# relaxed filter

delta-filter -i 70 -l 1000 \
$OUTDIR/assembled_vs_reference.delta \
> $OUTDIR/assembled_vs_reference.relaxed.delta

mummerplot --png --layout \
--prefix=$OUTDIR/assembled_vs_reference_relaxed \
$OUTDIR/assembled_vs_reference.relaxed.delta


# 1-to-1 filter

delta-filter -1 \
$OUTDIR/assembled_vs_reference.delta \
> $OUTDIR/assembled_vs_reference.1to1.delta

mummerplot --png --layout \
--prefix=$OUTDIR/assembled_vs_reference_1to1 \
$OUTDIR/assembled_vs_reference.1to1.delta
