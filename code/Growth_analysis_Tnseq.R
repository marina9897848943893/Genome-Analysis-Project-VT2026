# Load library
library("DESeq2")
library("ggplot2")

# Sample metadata
sampleTable <- data.frame(

    sampleName = c(
        "ERR1801006","ERR1801007","ERR1801008",   # Serum
        "ERR1801009","ERR1801010","ERR1801011",   # HSerum
        "ERR1801012","ERR1801013","ERR1801014"    # BHI
    ),

    fileName = c(
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/Serum/ERR1801006_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/Serum/ERR1801007_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/Serum/ERR1801008_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/HSerum/ERR1801009_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/HSerum/ERR1801010_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/HSerum/ERR1801011_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/BHI/ERR1801012_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/BHI/ERR1801013_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/BHI/ERR1801014_counts.txt"
    ),

    condition = c(
        "Serum","Serum","Serum",
        "HSerum","HSerum","HSerum",
        "BHI","BHI","BHI"
    )
)

# Set rownames
rownames(sampleTable) <- sampleTable$sampleName

# Create DESeq dataset
dds <- DESeqDataSetFromHTSeqCount(
    sampleTable = sampleTable,
    directory = "/",
    design = ~ condition
)

# Run differential analysis
dds$condition <- relevel(dds$condition, ref = "BHI")
dds <- DESeq(dds)


# 1. Serum vs BHI (genes required for growth in serum)

res_serum_vs_bhi <- results(dds, contrast = c("condition","Serum","BHI"))
res_serum_vs_bhi <- res_serum_vs_bhi[order(res_serum_vs_bhi$padj), ]

write.csv(as.data.frame(res_serum_vs_bhi),
          "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/TnSeq_Serum_vs_BHI_results.csv")


# 2. Serum vs HSerum (complement-specific fitness genes)

res_serum_vs_hserum <- results(dds, contrast = c("condition","Serum","HSerum"))
res_serum_vs_hserum <- res_serum_vs_hserum[order(res_serum_vs_hserum$padj), ]

write.csv(as.data.frame(res_serum_vs_hserum),
          "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/TnSeq_Serum_vs_HSerum_results.csv")


# 3. HSerum vs BHI (serum-environment fitness genes)

res_hserum_vs_bhi <- results(dds, contrast = c("condition","HSerum","BHI"))
res_hserum_vs_bhi <- res_hserum_vs_bhi[order(res_hserum_vs_bhi$padj), ]

write.csv(as.data.frame(res_hserum_vs_bhi),
          "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/TnSeq_HSerum_vs_BHI_results.csv")


# Normalized counts

normalized_counts <- counts(dds, normalized=TRUE)

write.csv(
    normalized_counts,
    "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/TnSeq_normalized_counts.csv"
)


# MA plot (Serum vs BHI)

pdf("/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/TnSeq_MA_plot_Serum_vs_BHI.pdf")
plotMA(res_serum_vs_bhi,
       main = "TnSeq MA Plot (Serum vs BHI)",
       ylim = c(-5, 5))
dev.off()


# PCA plot

vsd <- varianceStabilizingTransformation(dds, blind = FALSE)

pcaData <- plotPCA(vsd, intgroup = "condition", returnData = TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))

pdf("/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/TnSeq_PCA_plot.pdf")
ggplot(pcaData, aes(PC1, PC2, color = condition)) +
    geom_point(size = 4) +
    xlab(paste0("PC1: ", percentVar[1], "% variance")) +
    ylab(paste0("PC2: ", percentVar[2], "% variance")) +
    ggtitle("PCA of TnSeq samples (Serum, HSerum, BHI)") +
    theme_minimal()
dev.off()


# Identify genes required for growth in human serum

# Read results
# Use full DESeq2 results (not the sorted table)
res <- as.data.frame(results(dds, contrast = c("condition","Serum","BHI")))
res$GeneID <- rownames(res)

# Filter for fitness genes (moderate depletion allowed)
fitness_genes <- subset(res, !is.na(padj) & log2FoldChange < -0.7 & padj < 0.1)

# Fitness genes = depleted in Serum (mutants die)
#fitness_genes <- subset(res, log2FoldChange < -0.7 & padj < 0.1)


# Load annotation
annotation <- read.delim(
    "/home/marinky/Genome-Analysis-Project-VT2026/results/Genome_Assembly/PacBio/Prokka-annotation-PacBio/Prokka_PacBio/Prokka_Annotation_PacBio.tsv"
)

# Merge annotation
fitness_annotated <- merge(
    fitness_genes,
    annotation,
    by.x = "GeneID",
    by.y = "locus_tag",
    all.x = TRUE
)

write.csv(
    fitness_annotated,
    "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Genes-growth/TnSeq_Serum_fitness_genes_annotated.csv",
    row.names = FALSE
)


# Print summary

cat("Total significant genes (Serum vs BHI):", nrow(subset(res, padj < 0.05)), "\n")
cat("Genes REQUIRED for growth in human serum:", nrow(fitness_genes), "\n")

subset(fitness_annotated, grepl("pur|pyr|phosphotransferase|PTS|nucleotide", product, ignore.case = TRUE))
