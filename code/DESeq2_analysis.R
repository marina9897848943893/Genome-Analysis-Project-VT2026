# Load library
library("DESeq2")

# Sample metadata
sampleTable <- data.frame(
    sampleName = c(
	"ERR1797969",
        "ERR1797970",
        "ERR1797971",
        "ERR1797972",
        "ERR1797973",
        "ERR1797974"
    ),

    fileName = c(
	"/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Htseq-Serum/ERR1797969_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Htseq-Serum/ERR1797970_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Htseq-Serum/ERR1797971_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Htseq-BH/ERR1797972_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Htseq-BH/ERR1797973_counts.txt",
        "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Htseq-BH/ERR1797974_counts.txt"
   ),

    condition = c(
        "Serum",
        "Serum",
        "Serum",
        "BH",
        "BH",
        "BH"
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

# Run differential expression
dds <- DESeq(dds)

# Extract results
res <- results(dds)

# Sort by adjusted p-value
resOrdered <- res[order(res$padj), ]

# Write results
write.csv(
    as.data.frame(resOrdered),
    file = "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Differential-expression/deseq2_results.csv"
)

# Save normalized counts
normalized_counts <- counts(dds, normalized=TRUE)

write.csv(
    normalized_counts,
    file = "/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Differential-expression/normalized_counts.csv"
)

# MA plot
pdf("/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Differential-expression/MA_plot.pdf")

plotMA(res,
       main = "DESeq2 MA Plot (Serum vs BH)",
       ylim = c(-5, 5))

dev.off()

# Volcano plot
#library("EnhancedVolcano")

#pdf("/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Differential-expression/volcano_plot.pdf")

#EnhancedVolcano(res,
 #   lab = rownames(res),
 #  x = 'log2FoldChange',
 #   y = 'pvalue',
 #   pCutoff = 0.05,
 #   FCcutoff = 1.5,
 #   title = 'Serum vs BH')

#dev.off()

# PCA plot
# transform counts for visualization
vsd <- vst(dds, blind = FALSE)

# PCA plot
pcaData <- plotPCA(vsd, intgroup = "condition", returnData = TRUE)

percentVar <- round(100 * attr(pcaData, "percentVar"))

library(ggplot2)

pdf("/home/marinky/Genome-Analysis-Project-VT2026/results/RNA-seq/Differential-expression/PCA_plot.pdf")

ggplot(pcaData, aes(PC1, PC2, color = condition)) +
    geom_point(size = 4) +
    xlab(paste0("PC1: ", percentVar[1], "% variance")) +
    ylab(paste0("PC2: ", percentVar[2], "% variance")) +
    ggtitle("PCA of RNA-seq samples (Serum vs BH)") +
    theme_minimal()

dev.off()
