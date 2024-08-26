bioc_pkgs<-c(
"doMC", "doRNG","doSNOW", "mixtools", "SummarizedExperiment", "SingleCellExperiment", "DESeq2"
)

requireNamespace("BiocManager")
BiocManager::install(bioc_pkgs,ask=FALSE)
BiocManager::install("scater", ask=FALSE)

devtools::install_github("neurogenomics/scFlow")