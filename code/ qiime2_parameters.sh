
 #!/bin/bash

 ##RBCL
    
    fw1="^AGGTGAAGTAAAAGGTTCWTACTTAAA"
    fw2="^AGGTGAAGTTAAAGGTTCWTAYTTAAA"
    fw3="^AGGTGAAACTAAAGGTTCWTACTTAAA"
 
    rv1="^CCTTCTAATTTACCWACWACTG"
    rv2="^CCTTCTAATTTACCWACAACAG"

    cutadapt_config="--p-front-f $fw1 --p-front-f $fw2 --p-front-f $fw3 --p-front-r $rv1 --p-front-r $rv2"


    polyg_len=200
    
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

    refreads=${refreads:-/tmp/GEN711-811_data/refdbs/diat_barcode_v10_263bp-seqs.qza}
    reftax=${reftax:-/tmp/GEN711-811_data/refdbs/diat_barcode_v10_263bp-tax.qza}
    blastdb=${blastdb:-/tmp/GEN711-811_data/refdbs/blast_diat.barcode}
    sklearn=${sklearn:-/tmp/GEN711-811_data/refdbs/diat_barcode_v10_263bp-sklearn-classifier.qza}
