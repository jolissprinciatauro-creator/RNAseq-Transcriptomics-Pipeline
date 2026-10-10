###############################################################
# RNA-seq Transcriptomics Pipeline
# Configuration Template
#
# Copy this file and rename it to:
#     config.R
#
# IMPORTANT:
# - Do not upload config.R if it contains private paths or data.
# - Update the settings below for your own dataset.
###############################################################


###############################################################
# 1. INPUT / OUTPUT DIRECTORIES
###############################################################

# Directory containing the input count matrix
count_matrix_file <- "data/raw/count_matrix.csv"

# Sample metadata file
metadata_file <- "data/metadata/metadata.csv"

# Main results directory
results_dir <- "results"


###############################################################
# 2. SAMPLE METADATA COLUMNS
###############################################################

# Column containing sample identifiers
sample_id_column <- "Sample_ID"

# Column defining the biological condition/group
group_column <- "Group"

# Column defining the sequencing/technical batch
batch_column <- "Batch"


###############################################################
# 3. DIFFERENTIAL EXPRESSION SETTINGS
###############################################################

# Adjusted p-value threshold
padj_cutoff <- 0.05

# Absolute log2 fold-change threshold
log2fc_cutoff <- 1.2


###############################################################
# 4. LOW-EXPRESSION FILTERING
###############################################################

# Minimum sum of normalized counts across samples
min_normalized_count_sum <- 10


###############################################################
# 5. GENE FILTERING
###############################################################

# Restrict analysis to protein-coding genes
protein_coding_only <- TRUE

# Remove genes without an annotated gene symbol
remove_missing_symbols <- TRUE

# Strategy for duplicated gene symbols
# "highest_variance" keeps the gene entry with the highest
# expression variance across samples.
duplicate_gene_strategy <- "highest_variance"


###############################################################
# 6. LOG2 FOLD-CHANGE SHRINKAGE
###############################################################

# Method used for shrunken log2 fold changes
lfc_shrinkage_method <- "ashr"


###############################################################
# 7. ENRICHMENT ANALYSIS
###############################################################

# Organism
organism <- "human"

# Enrichment significance threshold
enrichment_padj_cutoff <- 0.05

# Minimum gene-set size for GSEA
gsea_min_gene_set_size <- 10

# Maximum gene-set size for GSEA
gsea_max_gene_set_size <- 500


###############################################################
# 8. VISUALIZATION
###############################################################

# Number of genes displayed in top-gene visualizations
top_n_genes <- 20

# Number of genes displayed in heatmaps
heatmap_top_n <- 50


###############################################################
# 9. REPRODUCIBILITY
###############################################################

# Random seed for analyses involving randomization
set.seed(123)


###############################################################
# END OF CONFIGURATION
###############################################################
