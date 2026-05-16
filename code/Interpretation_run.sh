#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J Interpretation-run
#SBATCH --mail-type=ALL

#SBATCH --output=Interpretation-run.out

# Load modules
module load R/4.5.1-gfbf-2024a

# Run Rscript
R
Rscript Interpretation_analysis.R
