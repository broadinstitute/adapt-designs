#!/bin/bash

source ../../../scripts/run-adapt/run_common.sh

# Set input
IN_TSV="in/taxa.tsv"
ONLY_DESIGN_FOR="in/only-design.tsv"

# These have a lot of diversity, especially the enteroviruses
# Relax some parameters; with the default, there are very few
# options for a several of the species
ARG_PM="3"
ARG_PP="0.85"
ARG_PRIMER_GC_LO="0.35"
ARG_PRIMER_GC_HI="0.65"
ARG_MAXPRIMERSATSITE="10"
ARG_IDM="3"
ARG_IDFRAC="0.10"

run-adapt design complete-targets auto-from-file $IN_TSV $OUT_DIR --obj maximize-activity --soft-guide-constraint $ARG_SOFTGUIDECONSTRAINT --hard-guide-constraint $ARG_HARDGUIDECONSTRAINT --penalty-strength $ARG_PENALTYSTRENGTH --maximization-algorithm $ARG_MAXIMIZATIONALGORITHM -gl $ARG_GL -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --id-m $ARG_IDM --id-frac $ARG_IDFRAC --id-method shard --max-primers-at-site $ARG_MAXPRIMERSATSITE --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-target-length $ARG_MAXTARGETLENGTH --obj-fn-weights $ARG_OBJFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --predict-activity-model-path $ARG_PREDICTIVE_MODELS --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --cluster-threshold $CLUSTER_THRESHOLD --only-design-for $ONLY_DESIGN_FOR --write-input-seqs --write-input-aln --ncbi-api-key $NCBI_API_KEY --verbose
