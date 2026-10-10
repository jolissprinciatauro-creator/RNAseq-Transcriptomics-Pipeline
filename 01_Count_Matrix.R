###############################################################
# RNA-seq Transcriptomics Pipeline
# Step 1: Count Matrix Construction
###############################################################
#
# Purpose:
# Combine individual sample-level RNA-seq count files into a
# single gene-by-sample count matrix for downstream analysis.
#
# Input:
# Individual .counts files containing gene-level read counts.
#
# Output:
# Combined raw count matrix.
#
# Main operations:
# - Identify count files
# - Read individual count tables
# - Merge samples using Ensembl gene identifiers
# - Perform basic matrix checks
# - Export the combined count matrix
#
###############################################################


##############################
# 1. LOAD PACKAGES
##############################

library(tidyverse)
library(openxlsx)


##############################
# 2. DEFINE DIRECTORIES
##############################

# Use a relative path so that the script does not contain
# project-specific or computer-specific file paths.

input_dir <- "data/raw"
output_dir <- "results"


##############################
# 3. IDENTIFY COUNT FILES
##############################

all_files <- dir(input_dir)

count_files <- grep(
  all_files,
  pattern = "\\.counts$",
  value = TRUE
)

if(length(count_files) == 0){
  
  stop(
    "No .counts files were found in the input directory."
  )
  
}


##############################
# 4. READ COUNT FILES
##############################

data_file <- map(
  file.path(input_dir, count_files),
  read.delim,
  sep = "",
  check.names = FALSE,
  stringsAsFactors = FALSE,
  header = TRUE,
  row.names = NULL
)


##############################
# 5. CHECK INPUT FILES
##############################

cat(
  "Number of count files:",
  length(data_file),
  "\n"
)

cat(
  "First file dimensions:",
  nrow(data_file[[1]]),
  "genes ×",
  ncol(data_file[[1]]),
  "columns\n"
)


##############################
# 6. MERGE COUNT FILES
##############################

# Merge all sample-level count tables using the
# Ensembl gene identifier as the common key.

counts <- Reduce(
  function(x, y) {
    
    merge(
      x,
      y,
      by = "Ensid"
    )
    
  },
  data_file
)


##############################
# 7. BASIC QUALITY CHECKS
##############################

cat(
  "Final count matrix dimensions:",
  nrow(counts),
  "genes ×",
  ncol(counts),
  "columns\n"
)

cat(
  "Duplicated gene identifiers:",
  sum(duplicated(counts$Ensid)),
  "\n"
)

cat(
  "Missing values:",
  sum(is.na(counts)),
  "\n"
)


##############################
# 8. CREATE OUTPUT DIRECTORY
##############################

dir.create(
  output_dir,
  recursive = TRUE,
  showWarnings = FALSE
)


##############################
# 9. EXPORT COUNT MATRIX
##############################

write.xlsx(
  counts,
  file.path(
    output_dir,
    "raw_count_matrix.xlsx"
  ),
  rowNames = FALSE
)


##############################
# 10. COMPLETION MESSAGE
##############################

cat(
  "\nCount matrix construction completed successfully.\n"
)

cat(
  "Output:",
  file.path(output_dir, "raw_count_matrix.xlsx"),
  "\n"
)


###############################################################
# END OF STEP 1
###############################################################
