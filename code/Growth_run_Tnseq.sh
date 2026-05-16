#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J Growth-run-Tnseq
#SBATCH --mail-type=ALL

#SBATCH --output=Growth-run-Tnseq.out

# Load modules
module load R/4.5.1-gfbf-2024a
module load R-bundle-Bioconductor/3.20-foss-2024a-R-4.4.2

# Run Rscript
Rscript Growth_analysis_Tnseq.R
