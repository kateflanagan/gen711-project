#!/bin/bash 
#will alter code environment to enable features
conda activate genomics 


cd ~/gen711-project

# make output directories. only run once. 
mkdir poly-G-trimmed html results metadata

#removes the poly G tails and filter out reads
# a 4 loop
chmod +x ../code/polyGfilter.sh
.../code/polyGfilter.sh ${polyg_len}

# if I don't want to run the loop, I can input the number instead
.../code/polyGfilter.sh 200

#remove empty files before qiime import 
find poly-G-trimmed -size 0 -print -delete

##next! 