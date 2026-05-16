# Read DESeq2 results
res <- read.csv(
    "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Differential-expression/deseq2_results.csv",
    row.names = 1
)

# Remove NA rows
res <- na.omit(res)

# Keep significant genes
sig_res <- subset(res, padj < 0.05)

# Define biologically relevant fold-change threshold
serum_up <- subset(sig_res, log2FoldChange > 1)

bh_up <- subset(sig_res, log2FoldChange < -1)

# Add gene IDs as column
serum_up$GeneID <- rownames(serum_up)
bh_up$GeneID <- rownames(bh_up)

# Read Prokka annotation
annotation <- read.delim(
    "/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Prokka-annotation-PacBio/Prokka_PacBio/Prokka_Annotation_PacBio.tsv"
)

# Merge annotation with DESeq2 results
serum_annotated <- merge(
    serum_up,
    annotation,
    by.x = "GeneID",
    by.y = "locus_tag",
    all.x = TRUE
)

bh_annotated <- merge(
    bh_up,
    annotation,
    by.x = "GeneID",
    by.y = "locus_tag",
    all.x = TRUE
)

# Save annotated tables
write.csv(
    serum_annotated,
    "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Differential-expression/serum_upregulated_annotated.csv",
    row.names = FALSE
)

write.csv(
    bh_annotated,
    "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Differential-expression/bh_upregulated_annotated.csv",
    row.names = FALSE
)

# Print summary
cat("Total significant genes:", nrow(sig_res), "\n")
cat("Genes upregulated in Serum:", nrow(serum_up), "\n")
cat("Genes upregulated in BH:", nrow(bh_up), "\n")
