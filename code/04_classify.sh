#!/bin/bash

#made changes here

primer="RBCL"
projname="DIATOMS_${primer}"
threads=15

## Classifiy
refreads=${refreads:-/home/unhAW/jtmiller/watts/ref-database/rbcl/diat_barcode_v10_263bp-seqs.qza}
reftax=${reftax:-/home/unhAW/jtmiller/watts/ref-database/rbcl/diat_barcode_v10_263bp-tax.qza}

sklearn=${sklearn:-/home/unhAW/jtmiller/watts/ref-database/rbcl/diat_barcode_v10_263bp-sklearn-classifier.qza}


## copied from qiime2_parameters.sh
maxaccepts=all
query_cov=0.80 
perc_identity=0.80
weak_id=0.50 

#tophit_perc_identity=0.90

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

  echo "Classification complete!"