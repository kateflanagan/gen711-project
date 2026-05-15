#!/bin/bash

# 1. Setting names 
primer="RBCL"
projname="DIATOMS_${primer}"

# 2. entering QIIME environment 
#conda activate qiime2-amplicon-2026.1

# 3. setting primers 
    fw1="^AGGTGAAGTAAAAGGTTCWTACTTAAA"
    fw2="^AGGTGAAGTTAAAGGTTCWTAYTTAAA"
    fw3="^AGGTGAAACTAAAGGTTCWTACTTAAA"

    rv1="^CCTTCTAATTTACCWACWACTG"
    rv2="^CCTTCTAATTTACCWACAACAG"

# 4. setting cutadapt configuration
cutadapt_config="--p-front-f $fw1 --p-front-f $fw2 --p-front-f $fw3 --p-front-r $rv1 --p-front-r $rv2"

# 5. Import FastQs
echo "Importing sequences..."
qiime tools import \
    --type "SampleData[PairedEndSequencesWithQuality]" \
    --input-format CasavaOneEightSingleLanePerSampleDirFmt \
    --input-path data/poly-G-trimmed/ \
    --output-path data/results/${projname}_demux.qza

# 6. trim primers
echo "Trimming primers..."
qiime cutadapt trim-paired \
    --i-demultiplexed-sequences data/results/${projname}_demux.qza \
    --p-error-rate 0.12 \
    --o-trimmed-sequences data/results/${projname}_demux_cutadapt.qza \
    --p-cores 16 \
    $cutadapt_config \
    --p-discard-untrimmed \
    --p-match-adapter-wildcards \
    --verbose

# 7. summarize
echo "Summarizing..."
qiime demux summarize \
    --i-data data/results/${projname}_demux_cutadapt.qza \
    --o-visualization data/results/${projname}_demux_cutadapt.qzv


echo "Cutadapt complete!"
