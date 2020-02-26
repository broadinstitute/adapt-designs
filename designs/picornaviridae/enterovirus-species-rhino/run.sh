#!/bin/bash

source ../../../scripts/run-adapt/run_common.sh

# Set input
IN_TSV="in/taxa.tsv"
ONLY_DESIGN_FOR="in/only-design.tsv"

# These have a lot of diversity, especially the enteroviruses
# Relax some parameters; with the default, there are very few
# options for a several of the species
ARG_GP="0.95"
ARG_PM="3"
ARG_PP="0.90"
ARG_PRIMER_GC_LO="0.35"
ARG_PRIMER_GC_HI="0.65"
ARG_MAXPRIMERSATSITE="10"
ARG_IDM="3"
ARG_IDFRAC="0.10"

# To handle diversity, also cluster sequences (default value
# does not cluster -- or, more specifically, always yields
# one cluster)
CLUSTER_THRESHOLD="1.0"

# Set a non-default activity threshold, lower than the default
# There is so much diversity in this family (including within-species),
# and that adds to the constraints; lowering the activity threshold
# frees up more designs
ARG_ACTIVITYTHRES="-1.0"

run-adapt complete-targets auto-from-file $IN_TSV $OUT_DIR -gl $ARG_GL -gm $ARG_GM -gp $ARG_GP -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --id-m $ARG_IDM --id-frac $ARG_IDFRAC --id-method shard --require-flanking3 H --max-primers-at-site $ARG_MAXPRIMERSATSITE --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-target-length $ARG_MAXTARGETLENGTH --cost-fn-weights $ARG_COSTFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --predict-activity-model-path $PREDICTIVE_MODEL --predict-activity-thres $ARG_ACTIVITYTHRES --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --cluster-threshold $CLUSTER_THRESHOLD --only-design-for $ONLY_DESIGN_FOR --write-input-seqs --write-input-aln --ncbi-api-key $NCBI_API_KEY --verbose
