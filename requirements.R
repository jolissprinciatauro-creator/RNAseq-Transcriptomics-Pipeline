###############################################################
# RNA-seq Transcriptomics Pipeline
# Required R / Bioconductor Packages
###############################################################

# Install BiocManager if required
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}


###############################################################
# Bioconductor packages
###############################################################

BiocManager::install(c(
    "DESeq2",
    "sva",
    "biomaRt",
    "ashr",
    "ComplexHeatmap",
    "clusterProfiler",
    "ReactomePA",
    "org.Hs.eg.db"
))


###############################################################
# CRAN packages
###############################################################

install.packages(c(
    "ggplot2",
    "ggrepel",
    "dplyr",
    "tidyr",
    "purrr",
    "readxl",
    "openxlsx",
    "pheatmap",
    "umap"
))


###############################################################
# Optional: verify installed packages
###############################################################

required_packages <- c(
    "DESeq2",
    "sva",
    "biomaRt",
    "ashr",
    "ComplexHeatmap",
    "clusterProfiler",
    "ReactomePA",
    "org.Hs.eg.db",
    "ggplot2",
    "ggrepel",
    "dplyr",
    "tidyr",
    "purrr",
    "readxl",
    "openxlsx",
    "pheatmap",
    "umap"
)

missing_packages <- required_packages[
    !sapply(required_packages, requireNamespace, quietly = TRUE)
]

if (length(missing_packages) == 0) {
    message("All required packages are installed.")
} else {
    message(
        "The following packages are missing: ",
        paste(missing_packages, collapse = ", ")
    )
}
