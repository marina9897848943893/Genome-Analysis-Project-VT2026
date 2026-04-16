#!/bin/bash -l
 
#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 1
#SBATCH -t 00:30:00 
#SBATCH -J Quast_Illumina-Nanopore
#SBATCH --mail-type=ALL 

#SBATCH --output=Quast_Illumina-Nanopore.out

# Load modules 
module load QUAST/5.3.0-gfbf-2024a

<<<<<<< Updated upstream
# Quast assembly evaluation on PacBio reads
=======
# Quast assembly evaluation on Illumina and Nanopore reads
>>>>>>> Stashed changes
python /sw/arch/eb/software/QUAST/5.3.0-gfbf-2024a/bin/quast.py /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/Illumina-Nanopore/SPAdes-assembly-Illumina_Nanopore/contigs.fasta \
	-o /home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly//Illumina-Nanopore/Quast-evaluation-Illumina_Nanopore
