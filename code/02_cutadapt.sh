#!/bin/bash


 RBCL
    
    fw1="^AGGTGAAGTAAAAGGTTCWTACTTAAA"
    fw2="^AGGTGAAGTTAAAGGTTCWTAYTTAAA"
    fw3="^AGGTGAAACTAAAGGTTCWTACTTAAA"
 
    rv1="^CCTTCTAATTTACCWACWACTG"
    rv2="^CCTTCTAATTTACCWACAACAG"

    cutadapt_config="--p-front-f $fw1 --p-front-f $fw2 --p-front-f $fw3 --p-front-r $rv1 --p-front-r $rv2"


    polyg_len=150
    
    ## denoise
    ## trunc
    trunclenr=200
    trunclenf=200
    ## trim
    trimleftf=0
    trimleftr=0

    overlap=12

    ## taxonomy
    maxaccepts=all
    query_cov=0.80 
    perc_identity=0.80
    weak_id=0.50 
    #tophit_perc_identity=0.90

primer="RBCL"
projname="DEP_${primer}"

conda activate qiime2-amplicon-2026.1

### import fastqs. Add the demultiplexed sequences to the data/results directory. This will create a .qza file that can be used for cutadapt and qiime2 downstream analyses.
qiime tools import \
    --type "SampleData[PairedEndSequencesWithQuality]"  \
    --input-format CasavaOneEightSingleLanePerSampleDirFmt \
    --input-path data/poly-G-trimmed \
    --output-path data/results/${projname}_demux 


## copied from qiime2_parameters.sh
fw='^GTGYCAGCMGCCGCGGTAA'	
rv='^CCGYCAATTYMTTTRAGTTT'
cutadapt_config="--p-front-f $fw --p-front-r $rv"

### See qiime2_parameters.sh for cutadapt parameters and 01_trim.sh for polyG filter parameters.
qiime cutadapt trim-paired \
    --i-demultiplexed-sequences data/results/${projname}_demux.qza \
    --p-error-rate 0.12 \
    --o-trimmed-sequences **data/**results/${projname}_demux_cutadapt.qza \
    --p-cores 4 \
    $cutadapt_config \
    --p-discard-untrimmed \
    --p-match-adapter-wildcards \
    --verbose 

qiime demux summarize \
    --i-data results/${projname}_demux_cutadapt.qza \
    --o-visualization **data/**results/${projname}_demux_cutadapt.qzv



