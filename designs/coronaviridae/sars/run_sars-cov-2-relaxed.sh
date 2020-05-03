#!/bin/bash

source ../../../scripts/run-adapt/run_common.sh

# Design only for SARS-CoV-2
IN_TSV="in/taxa.sars-cov-2-relaxed.tsv"

# Use FASTAs for SARS and its subgroupings
USE_FASTA="in/use-fasta.tsv"

# For specificity, be specific against everything in the
# SARS-related CoV species except for a couple of sequences
# extremely similar to SARS-CoV-2
SPECIFIC_AGAINST_FASTA="../input-fastas/fastas-for-design/SARS-CoV-2_loose-surrounding.fasta.gz"

# Also, be specific against all other taxa in this family;
# use a table for this that has all taxa except ones
# involving SARS
SPECIFIC_AGAINST_TAXA="in/taxids.non-sars.tsv"

# Increase the number of output designs
ARG_BESTNTARGETS="200"

# Enforce high specificity
ARG_IDM="4"
ARG_IDFRAC="0"

run-adapt sars-cov-2-relaxed complete-targets auto-from-file $IN_TSV $OUT_DIR --obj maximize-activity --soft-guide-constraint $ARG_SOFTGUIDECONSTRAINT --hard-guide-constraint $ARG_HARDGUIDECONSTRAINT --penalty-strength $ARG_PENALTYSTRENGTH --maximization-algorithm $ARG_MAXIMIZATIONALGORITHM -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --id-m $ARG_IDM --id-frac $ARG_IDFRAC --id-method shard --max-primers-at-site $ARG_MAXPRIMERSATSITE --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-target-length $ARG_MAXTARGETLENGTH --obj-fn-weights $ARG_OBJFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --predict-activity-model-path $ARG_PREDICTIVE_MODELS --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --cluster-threshold $CLUSTER_THRESHOLD --use-fasta $USE_FASTA --specific-against-taxa $SPECIFIC_AGAINST_TAXA --specific-against-fastas $SPECIFIC_AGAINST_FASTA --ncbi-api-key $NCBI_API_KEY --verbose
