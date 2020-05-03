#!/bin/bash

source ../../../scripts/run-adapt/run_common.sh

# Set input
IN_TSV="in/taxa.tsv"

# Use FASTAs for SARS and its subgroupings
USE_FASTA="in/use-fasta.tsv"

# The taxonomies overlap, which complicates specificity
# Do not be specific against within-SARS strains when designing
# for the SARS species; likewise, when designing for
# within-SARS strains, do not be specific against the whole
# SARS species
SPECIFICITY_IGNORE="in/specificity-ignore.tsv"

# For all of these designs, increase the number of output designs
ARG_BESTNTARGETS="200"

# Design only for SARS-like, using custom parameters
# This is a *very* challenging design to make, and requires relaxing
# many parameters relative to the defaults (to even get any
# potential targets) -- notably, the primer constraints are
# relaxed, as well as coverage and specificity
ONLY_DESIGN_FOR="in/only-design.sars-like.tsv"
ARG_PM="2"
ARG_PP="0.90"
ARG_PRIMER_GC_LO="0.35"
ARG_PRIMER_GC_HI="0.65"
ARG_IDM="3"
ARG_IDFRAC="0.10"
run-adapt sars-like complete-targets auto-from-file $IN_TSV $OUT_DIR --obj maximize-activity --soft-guide-constraint $ARG_SOFTGUIDECONSTRAINT --hard-guide-constraint $ARG_HARDGUIDECONSTRAINT --penalty-strength $ARG_PENALTYSTRENGTH --maximization-algorithm $ARG_MAXIMIZATIONALGORITHM -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --id-m $ARG_IDM --id-frac $ARG_IDFRAC --id-method shard --max-primers-at-site $ARG_MAXPRIMERSATSITE --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-target-length $ARG_MAXTARGETLENGTH --obj-fn-weights $ARG_OBJFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --predict-activity-model-path $ARG_PREDICTIVE_MODELS --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --cluster-threshold $CLUSTER_THRESHOLD --only-design-for $ONLY_DESIGN_FOR --use-fasta $USE_FASTA --taxa-to-ignore-for-specificity $SPECIFICITY_IGNORE --write-input-seqs --write-input-aln --ncbi-api-key $NCBI_API_KEY --verbose
