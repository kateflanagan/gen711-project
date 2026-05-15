#!/bin/bash

primer="RBCL"
projname="DIATOMS_${primer}"

conda activate qiime2-amplicon-2026.1

threads=16
overlap=10

## trunc
trunclenf=220
trunclenr=200
    
## trim
trimleftf=0
trimleftr=0

echo "begin denoise..."

qiime dada2 denoise-paired \
    --i-demultiplexed-seqs data/results/${projname}_demux_cutadapt.qza  \
    --p-trunc-len-f ${trunclenf} \
    --p-trunc-len-r ${trunclenr} \
    --p-trim-left-f ${trimleftf} \
    --p-trim-left-r ${trimleftr} \
    --p-n-threads ${threads} \
    --p-pooling-method 'pseudo' \
    --p-min-overlap ${overlap} \
    --p-allow-one-off \
    --o-denoising-stats data/results/${projname}_dns.qza \
    --o-base-transition-stats data/results/${projname}_base-transitions.qza \
    --o-table data/results/${projname}_table.qza \
    --o-representative-sequences data/results/${projname}_rep-seqs.qza

echo "Denoise complete!"