#!/bin/bash

source ../../../scripts/run-adapt/run_common.sh

# Set input
taxid="11103"
segment="None"
refseqs="NC_030791,NC_009827,NC_009825,NC_009824,NC_004102,NC_038882,NC_004102,NC_009827,NC_009826,NC_009825,NC_038882,NC_009824,NC_009823,NC_030791"

# Set what to be specific against
ARG_SPECIFICAGAINST="in/specific-against.tsv"

# Allow multiple clusters; otherwise the alignment is very gappy
CLUSTER_THRESHOLD="0.3"

# Adjust primer criteria for this highly diverse taxon
ARG_PM="3"
ARG_MAXPRIMERSATSITE="10"
ARG_PP="0.9"

run-adapt design complete-targets auto-from-args $taxid "$segment" $refseqs $OUT_DIR/design.tsv --obj maximize-activity --soft-guide-constraint $ARG_SOFTGUIDECONSTRAINT --hard-guide-constraint $ARG_HARDGUIDECONSTRAINT --penalty-strength $ARG_PENALTYSTRENGTH --maximization-algorithm $ARG_MAXIMIZATIONALGORITHM -gl $ARG_GL -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-primers-at-site $ARG_MAXPRIMERSATSITE --max-target-length $ARG_MAXTARGETLENGTH --obj-fn-weights $ARG_OBJFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --id-m $ARG_IDM --id-frac $ARG_IDFRAC --id-method shard --specific-against-taxa $ARG_SPECIFICAGAINST --predict-activity-model-path $ARG_PREDICTIVE_MODELS --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --ncbi-api-key $NCBI_API_KEY --cluster-threshold $CLUSTER_THRESHOLD --write-input-aln $OUT_DIR/hepacivirus_c.fasta --verbose
