#!/bin/bash

# Establishing project variables
primer="RBCL"
projname="DIATOMS_${primer}"

# Entering QIIME conda environment
conda activate qiime2-amplicon-2026.1  

# Setting computing power variable; 15 threads was used because this script was run outside of class time, so more computing power could be used
threads=15

## Classifiy variables, copied from qiime2_parameters.sh > these are the inputs so the classifier can see how the taxa and reads need to be classified
    refreads="data/refdb/diat_barcode_v10_263bp-seqs.qza"
    reftax="data/refdb/diat_barcode_v10_263bp-tax.qza"

## Using given classifier
    sklearn="data/refdb/diat_barcode_v10_263bp-sklearn-classifier_1.4.2.qza"

## Parameters copied from qiime2_parameters.sh to run the qiime classifier
    ## taxonomy
    maxaccepts=all
    query_cov=0.80 
    perc_identity=0.80
    weak_id=0.50 

#Running the qiime classifier based on parameters to organize data in a specific manner to aid in taxa bar plot creation
qiime feature-classifier classify-hybrid-vsearch-sklearn \
  --i-query data/results/${projname}_rep-seqs.qza \
  --i-classifier ${sklearn} \
  --i-reference-reads ${refreads} \
  --i-reference-taxonomy  ${reftax} \
  --p-threads ${threads} \
  --p-query-cov ${query_cov} \
  --p-perc-identity ${perc_identity} \
  --p-maxrejects all \
  --p-maxaccepts ${maxaccepts} \
  --p-maxhits all \
  --p-min-consensus 0.51 \
  --p-confidence 0.7 \
  --o-classification data/results/${projname}_hybrid_taxonomy.qza