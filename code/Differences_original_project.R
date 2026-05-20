##Identify the similarities and the differences between the upregulated genes in serum##
##from original paper and from differential expression analysis of this project##

#Working directory
getwd()

#Load both CSV files
df1 <- read.csv("serum_upregulated_annotated.csv", stringsAsFactors = FALSE)
#df2 <- read.csv("12864_2017_4299_MOESM4_ESM.csv, stringsAsFactors = FALSE)

#Load df2 but SKIP the first 2 garbage rows
df2 <- read.csv("12864_2017_4299_MOESM4_ESM.csv",
                skip = 2,
                header = TRUE,
                stringsAsFactors = FALSE)

#Clean df2 column names (remove weird dots)
colnames(df2) <- make.names(colnames(df2))


#Extract gene name columns
genes1 <- df1$gene
genes2 <- df2$Name

#Find overlapping genes
common_genes <- intersect(genes1, genes2)
print("Common genes:")
print(common_genes)
print(paste("Number of common genes:", length(common_genes)))
write.csv(data.frame(common_genes), "common_genes.csv", row.names = FALSE)
