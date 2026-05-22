##Read count plot##

#Working directory
getwd()

#HTSeq count files
fileName <- c("ERR1797969_counts.txt",
              "ERR1797970_counts.txt",
              "ERR1797971_counts.txt",
              "ERR1797972_counts.txt",
              "ERR1797973_counts.txt",
              "ERR1797974_counts.txt")

#Load all files into a list
count_list <- lapply(fileName, function(f) {
  read.table(f, header = FALSE, col.names = c("gene", f))
})

#Merge all files by gene - histogram of read counts per gene
install.packages("dplyr")
library(dplyr)

counts <- Reduce(function(x, y) full_join(x, y, by = "gene"), count_list)

#Remove HTSeq summary rows (start with "__")
counts <- counts[!grepl("^__", counts$gene), ]

#Compute mean counts per gene across all samples
gene_means <- rowMeans(counts[ , -1])   # remove gene column

#Plot histogram
pdf("Read count raw histogram.pdf")

hist(gene_means,
     breaks = 100,
     main = "Histogram of mean counts per gene",
     xlab = "Mean counts",
     col = "steelblue")

dev.off()

#Plot log10 histogram
pdf("Read count log 10 histogram.pdf")

hist(log10(gene_means + 1),
     breaks = 100,
     main = "Log10 histogram of mean counts per gene",
     xlab = "log10(mean counts + 1)",
     col = "red")

dev.off()

#Are most genes expressed?
perc <- mean(gene_means > 0) * 100

