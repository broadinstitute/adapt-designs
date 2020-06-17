#!/bin/bash

# Design panel.

source ../../../scripts/run-adapt/run_common.sh

# Set input
IN_TSV="in/taxa.tsv"

# Relax some parameters; with the default, there are no IAV designs
ARG_PP="0.90"

# Make accessions input file
ACCESSIONS_TO_USE="in/accessions-to-use.tsv"
cat ../accession-lists/IAV.Hany-Nany.segment2.acc.txt | grep . | awk '{print "11320\t2\t"$1}' > $ACCESSIONS_TO_USE
cat ../accession-lists/IBV.segment1.acc.txt | grep . | awk '{print "11520\t1\t"$1}' >> $ACCESSIONS_TO_USE

# Run the design
run-adapt design complete-targets auto-from-file $IN_TSV $OUT_DIR --obj maximize-activity --soft-guide-constraint $ARG_SOFTGUIDECONSTRAINT --hard-guide-constraint $ARG_HARDGUIDECONSTRAINT --penalty-strength $ARG_PENALTYSTRENGTH --maximization-algorithm $ARG_MAXIMIZATIONALGORITHM -gl $ARG_GL -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --id-m $ARG_IDM --id-frac $ARG_IDFRAC --id-method shard --max-primers-at-site $ARG_MAXPRIMERSATSITE --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-target-length $ARG_MAXTARGETLENGTH --obj-fn-weights $ARG_OBJFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --predict-activity-model-path $ARG_PREDICTIVE_MODELS --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --cluster-threshold $CLUSTER_THRESHOLD --use-accessions $ACCESSIONS_TO_USE --write-input-seqs --write-input-aln --ncbi-api-key $NCBI_API_KEY --verbose
