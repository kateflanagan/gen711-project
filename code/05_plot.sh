#!/bin/bash

#set variables
primer="RBCL"
projname="DIATOMS_${primer}"

#activate qiime2 environment
conda activate qiime2-amplicon-2026.1

#grouping and renaming
qiime feature-table group \
    --i-table data/results/${projname}_table.qza \
    --p-axis sample \
    --m-metadata-file data/metadata/rename-2025.tsv \
    --m-metadata-column Newname \
    --p-mode sum \
    --o-grouped-table data/results/MassDEP_2025-renamed_table.qza

#only use samples in metadata file
qiime feature-table filter-samples \
    --i-table data/results/MassDEP_2025-renamed_table.qza \
    --m-metadata-file data/metadata/MassDEP_2022-2025-renamed.tsv \
    --o-filtered-table data/results/filtered_MassDEP_2022-2025_rbcl_table.qza

# Output visualization > plot making (Taxa Bar Plot)
qiime taxa barplot \
    --i-table data/results/${projname}_taxonomy-matched-table.qza \
    --i-taxonomy data/results/${projname}_hybrid_taxonomy.qza \
    --m-metadata-file data/metadata/MassDEP_2022-2025-renamed.tsv \
    --o-visualization plots/${projname}_taxa_barplot.qzv


## To view the interactive barplot, you can use the qiime2 view command or upload the .qzv file to https://view.qiime2.org/ to interactively explore the plot. You can also export the plot as a .png file. Screenshots of the barplots work as well
## To download the .qzv file, right click on the file in vscode to download it to your local computer, then you can upload it to the qiime2 view website.


## Make a phylogenetic tree and run core metrics to get the alpha and beta diversity metrics for each sample. This will be used in the next script to create a PCoA plot of the beta diversity metrics.
qiime phylogeny align-to-tree-mafft-fasttree \
   --i-sequences data/results/${projname}_rep-seqs.qza \
   --o-alignment data/results/${projname}_aligned-rep-seqs \
   --o-masked-alignment data/results/${projname}_masked-aligned-rep-seqs.qza\
   --o-tree data/results/${projname}_unrooted-tree.qza\
   --o-rooted-tree data/results/${projname}_rooted-tree.qza\
   --p-n-threads 24

### Core Metrics (this will generate the alpha and beta diversity metrics for each sample, which will be used in the next script to create a PCoA plot of the beta diversity metrics)
### Choose one diversity ordination to vizualize in the readme of your github. Justify why you chose that one. You can also make multiple ordination plots if you want to compare the different beta diversity metrics.
qiime diversity core-metrics-phylogenetic \
    --i-phylogeny data/results/${projname}_rooted-tree.qza \
    --i-table data/results/${projname}_taxonomy-matched-table.qza \
    --p-with-replacement \
    --p-sampling-depth 500 \
    --m-metadata-file data/metadata/MassDEP_2022-2025-renamed.tsv \
    --output-dir data/results/${projname}_core-metrics-results

# Moving visualized (.qzv) files to plots folder
mv data/results/${projname}_core-metrics-results/*.qzv plots/