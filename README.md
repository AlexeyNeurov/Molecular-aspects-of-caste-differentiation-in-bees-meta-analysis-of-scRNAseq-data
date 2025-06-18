# Molecular-aspects-of-caste-differentiation-in-bees-meta-analysis-of-scRNAseq-data
Project defense

# File Descriptions for GitHub:

1. Data Acquisition - download.sh  
- Purpose: Downloads scRNA-seq data from different bee castes from NCBI SRA.  
- Tools: SRA Toolkit (fasterq-dump).  
- Actions:  
  - Fetches raw .fasta files.  
  - Converts to FASTQ format for downstream processing.  

2. Compression - gzip.sh  
- Purpose: Optimizes storage and I/O efficiency.  
- Action: Compresses FASTQ files using gzip.  

3. Data Preprocessing - Snakefile_trim1  
- Purpose: Quality control and adapter removal.  
- Tools: fastp.  
- Actions:  
  - Trims low-quality sequences and adapters.  
  - Parameters optimized to minimize data loss.  

4. Mapping - kal_bash.sh  
- Purpose: Alignment of reads to the reference genome.  
- Tools: kallisto.  
- Optimization: Parameters tuned for scRNA-seq data accuracy.  

5. Data Correction - bustools.sh  
- Purpose: Post-processing of aligned data.  
- Tools: Bustools.  
- Actions:  
  - Corrects and sorts mapped sequences.  
  - Formats data for efficient analysis.  

6. Analysis - Python Scripts  
- Purpose: Final data integration and exploration.  
- Actions:  
  - Merges datasets from multiple samples.  
  - Filters low-quality cells.  
  - Performs bioinformatic analysis (e.g., clustering, visualization).  
