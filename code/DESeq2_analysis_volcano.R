# Load library
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.23")

BiocManager::install("DESeq2")
library(DESeq2)

# Sample metadata
sampleTable <- data.frame(
    sampleName = c("ERR1797969",
                   "ERR1797970",
                   "ERR1797971",
                   "ERR1797972",
                   "ERR1797973",
                   "ERR1797974"),

    fileName = c("ERR1797969_counts.txt",
    "ERR1797970_counts.txt",
    "ERR1797971_counts.txt",
    "ERR1797972_counts.txt",
    "ERR1797973_counts.txt",
    "ERR1797974_counts.txt"
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
    #directory = "/",
    design = ~ condition
)

# Run differential expression
dds$condition <- relevel(dds$condition, ref = "BH") 
dds <- DESeq(dds)

# Extract results
res <- results(dds)

# Sort by adjusted p-value
resOrdered <- res[order(res$padj), ]

# Write results
write.csv(
    as.data.frame(resOrdered),
    file = "deseq2_results.csv"
)

# Save normalized counts
normalized_counts <- counts(dds, normalized=TRUE)

write.csv(
    normalized_counts,
    file = "normalized_counts.csv"
)

# MA plot
#pdf("MA_plot.pdf")

#plotMA(res,
 #      main = "DESeq2 MA Plot (Serum vs BH)",
 #       ylim = c(-5, 5))

#dev.off()

# Volcano plot
BiocManager::install("EnhancedVolcano")
library("EnhancedVolcano")

pdf("volcano_plot.pdf")

EnhancedVolcano(res,
                lab = rownames(res),
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0.05,
                FCcutoff = 1.5,
                title = 'Serum vs BH')

dev.off()