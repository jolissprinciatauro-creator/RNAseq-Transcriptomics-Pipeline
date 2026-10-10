# RNA-seq Transcriptomics Analysis Pipeline

A reproducible R-based workflow for bulk RNA-seq transcriptomics analysis, covering quality control, batch correction, gene annotation, differential expression, visualization, functional enrichment, GSEA, and cross-comparison analysis.

---

## Overview

This repository contains a modular RNA-seq analysis workflow developed in R and designed to demonstrate a complete transcriptomics analysis pipeline from count data to biological interpretation.

The workflow is organized into independent analysis stages so that each step can be inspected, modified, and reproduced using a user's own RNA-seq dataset.

### Main workflow

**Raw count matrix**  
↓  
**Raw-count QC and UMAP**  
↓  
**Batch correction with ComBat-seq**  
↓  
**Post-correction QC**  
↓  
**Gene annotation and filtering**  
↓  
**Differential expression with DESeq2**  
↓  
**PCA / UMAP / Volcano plots / Heatmaps**  
↓  
**GO / KEGG / Reactome enrichment**  
↓  
**GSEA**  
↓  
**Cross-comparison consistency analysis**

---

## Repository Structure

```text
RNAseq-Transcriptomics-Pipeline/
│
├── 01_Count_Matrix/
│   └── 01_build_count_matrix.R
│
├── 02_QC/
│   └── 02_raw_count_UMAP.R
│
├── 03_Batch_Correction/
│   └── 03_ComBat_seq.R
│
├── 04_Post_Batch_QC/
│   └── 04_corrected_count_UMAP.R
│
├── 05_Annotation_and_Filtering/
│   └── 05_gene_annotation_filtering.R
│
├── 06_Differential_Expression/
│   └── 06_DESeq2_analysis.R
│
├── 07_Visualization/
│   └── 07_PCA_UMAP_Volcano_Heatmap.R
│
├── 08_Enrichment/
│   └── 08_GO_KEGG_Reactome_GSEA.R
│
├── 09_Cross_Comparison/
│   └── 09_cross_comparison_consistency.R
│
├── data/
│   ├── raw/
│   └── metadata/
│
├── results/
│
├── config_template.R
├── .gitignore
└── README.md
```

---

## Workflow Description

### 01. Count Matrix Construction

Builds a gene-level count matrix from individual sample count files.

**Input:** Sample-level count files  
**Output:** Gene × sample count matrix

---

### 02. Raw Count Quality Control

Performs exploratory QC using raw count data and UMAP to identify potential sample-level structure and batch-related separation.

**Key method:** UMAP

The raw-count UMAP is used as an initial exploratory QC step before batch correction.

---

### 03. Batch Correction

Corrects unwanted technical variation using **ComBat-seq** while retaining the biological structure of interest.

**Key method:** ComBat-seq

Batch information should be provided through the user's own metadata.

---

### 04. Post-Batch QC

Repeats dimensionality-reduction analysis after batch correction to evaluate whether batch-associated separation has been reduced.

**Key methods:**

- UMAP
- Batch-wise visualization
- Sample-level inspection

---

### 05. Gene Annotation and Filtering

Annotates Ensembl gene identifiers and applies gene-level filtering and quality control.

The workflow includes:

- Ensembl → gene symbol annotation
- Protein-coding gene filtering
- Removal of missing gene symbols
- Identification of duplicated gene symbols
- Selection of a representative gene entry based on expression variability

---

### 06. Differential Expression

Performs differential expression analysis using **DESeq2**.

The workflow includes:

- DESeq2 dataset construction
- Size-factor normalization
- Low-expression filtering
- Wald testing
- Differential expression statistics
- Cook's distance diagnostics
- Log2 fold-change shrinkage using `ashr`

---

### 07. Visualization

Generates commonly used transcriptomics visualizations for exploring sample structure and differential expression.

**Visualizations include:**

- PCA
- UMAP
- Volcano plots
- Heatmaps
- Top-gene expression visualization

Variance-stabilizing transformation (VST) is used for appropriate downstream visualization and dimensionality-reduction analyses.

---

### 08. Functional Enrichment and GSEA

Investigates the biological functions associated with differential expression results.

**Over-representation analyses:**

- Gene Ontology (GO)
- KEGG
- Reactome

**Gene Set Enrichment Analysis:**

GSEA uses a ranked genome-wide gene list based on the DESeq2 test statistic rather than restricting the analysis to statistically significant genes.

---

### 09. Cross-Comparison Consistency

Compares differential expression results across multiple independent comparisons.

Genes are classified according to their direction and consistency of regulation across comparisons.

This allows identification of:

- Consistently upregulated genes
- Consistently downregulated genes
- Mixed-direction genes
- Genes recurring across multiple comparisons

Consistency tiers can then be used to prioritize robust candidates for downstream interpretation.

---

## Main R / Bioconductor Packages

### Core analysis

- `DESeq2`
- `sva`
- `biomaRt`
- `ashr`

### Visualization

- `ggplot2`
- `ggrepel`
- `pheatmap`
- `ComplexHeatmap`
- `umap`
- `dplyr`

### Functional analysis

- `clusterProfiler`
- `ReactomePA`
- `org.Hs.eg.db`

### Data handling

- `openxlsx`
- `readxl`
- `tidyr`
- `purrr`

---

## Installation

The workflow requires **R** and **Bioconductor**.

Install Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
```

Install the main Bioconductor packages:

```r
BiocManager::install(c(
    "DESeq2",
    "sva",
    "biomaRt",
    "ashr",
    "clusterProfiler",
    "ReactomePA",
    "org.Hs.eg.db"
))
```

Install CRAN packages:

```r
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
```

`ComplexHeatmap` can be installed through Bioconductor:

```r
BiocManager::install("ComplexHeatmap")
```

---

## Input Data

The repository is designed to work with user-provided RNA-seq count data and sample metadata.

Typical inputs include:

### Count matrix

A matrix containing:

- Gene identifiers
- Sample identifiers
- Raw integer counts

Example structure:

```text
Gene_ID    Sample_01    Sample_02    Sample_03
GENE_001   125          98           143
GENE_002   0            12           8
GENE_003   421          390          455
```

### Metadata

Sample-level metadata should contain the information required for the analysis, such as:

- Sample ID
- Biological group
- Batch
- Other relevant experimental variables

The exact metadata structure should be adapted to the user's study design.

---

## Configuration

Study-specific settings should be defined separately from the analysis scripts.

Use:

```text
config_template.R
```

as a starting point for defining:

- Input directories
- Output directories
- Metadata columns
- Batch variables
- Experimental groups
- Differential expression thresholds

This keeps the analysis scripts reusable and prevents study-specific information from being hard-coded throughout the workflow.

---

## Reproducibility

The workflow is intentionally divided into sequential scripts rather than one large analysis file.

This makes it possible to:

- Run individual analysis stages independently
- Inspect intermediate results
- Modify parameters without rewriting the entire workflow
- Reuse the pipeline with different datasets
- Track each stage of the analysis clearly

Scripts should be executed in numerical order.

---

## Data and Privacy

**No original research datasets, patient-level information, clinical metadata, institutional files, or unpublished study results are included in this repository.**

The scripts have been generalized to demonstrate the analytical methods without exposing confidential or study-specific information.

Users should place their own permitted data in the appropriate `data/` directories and update the configuration accordingly.

Raw data and private metadata should **not** be committed to GitHub.

---

## Skills Demonstrated

This project demonstrates practical experience in:

- Bulk RNA-seq analysis
- Transcriptomic quality control
- Batch-effect assessment
- ComBat-seq batch correction
- Gene annotation
- Expression filtering
- DESeq2 differential expression analysis
- Wald testing
- Cook's distance diagnostics
- Log2 fold-change shrinkage
- PCA and UMAP
- Volcano plots
- Heatmaps
- GO enrichment
- KEGG enrichment
- Reactome enrichment
- GSEA
- Cross-comparison analysis
- R / Bioconductor workflow development
- Reproducible bioinformatics analysis

---

## Author

**Joliss Princia Tauro**  
MSc Bioinformatics

---

## Note

This repository is intended as a portfolio and reproducibility-oriented demonstration of RNA-seq analysis workflows.

Analysis parameters should always be adapted to the experimental design, dataset characteristics, and biological question of the study being analyzed.
