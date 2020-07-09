#!/bin/bash

# SARS-CoV-2, but without enforcing specificity
# This is useful to get more targets/design options

# This uses a format different than run_sars-cov-2.sh to more
# easily avoid enforcing specificity.

source ../../../scripts/run-adapt/run_common.sh

# Design only for SARS-CoV-2
IN_TSV="in/taxa.sars-cov-2-nonspecific.tsv"

# Use FASTAs for SARS and its subgroupings
USE_FASTA="in/use-fasta.tsv"

# Increase the number of output designs
ARG_BESTNTARGETS="250"

# Because we know these will generally have just 1 guide, use 'greedy' instead
# of 'random-greedy' for more intuitive results
ARG_MAXIMIZATIONALGORITHM="greedy"

run-adapt sars-cov-2-nonspecific complete-targets auto-from-file $IN_TSV $OUT_DIR --obj maximize-activity --soft-guide-constraint $ARG_SOFTGUIDECONSTRAINT --hard-guide-constraint $ARG_HARDGUIDECONSTRAINT --penalty-strength $ARG_PENALTYSTRENGTH --maximization-algorithm $ARG_MAXIMIZATIONALGORITHM -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --max-primers-at-site $ARG_MAXPRIMERSATSITE --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-target-length $ARG_MAXTARGETLENGTH --obj-fn-weights $ARG_OBJFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --predict-activity-model-path $ARG_PREDICTIVE_MODELS --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --cluster-threshold $CLUSTER_THRESHOLD --use-fasta $USE_FASTA --ncbi-api-key $NCBI_API_KEY --verbose
