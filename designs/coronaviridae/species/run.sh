#!/bin/bash

source ../../../scripts/run-adapt/run_common.sh

# Set input
IN_TSV="in/taxa.tsv"

# Do not design for SARS species
ONLY_DESIGN_FOR="in/only-design.tsv"

# For SARS species (needed for specificity), use FASTA
USE_FASTA="in/use-fasta.tsv"

run-adapt species complete-targets auto-from-file $IN_TSV $OUT_DIR --obj maximize-activity --soft-guide-constraint $ARG_SOFTGUIDECONSTRAINT --hard-guide-constraint $ARG_HARDGUIDECONSTRAINT --penalty-strength $ARG_PENALTYSTRENGTH --maximization-algorithm $ARG_MAXIMIZATIONALGORITHM -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --id-m $ARG_IDM --id-frac $ARG_IDFRAC --id-method shard --max-primers-at-site $ARG_MAXPRIMERSATSITE --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-target-length $ARG_MAXTARGETLENGTH --obj-fn-weights $ARG_OBJFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --predict-activity-model-path $ARG_PREDICTIVE_MODELS --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --cluster-threshold $CLUSTER_THRESHOLD --only-design-for $ONLY_DESIGN_FOR --use-fasta $USE_FASTA --write-input-seqs --write-input-aln --ncbi-api-key $NCBI_API_KEY --verbose
