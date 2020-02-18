#!/bin/bash

source ../../../scripts/run-adapt/run_common.sh

# Set input
IN_TSV="in/taxa.tsv"
ONLY_DESIGN_FOR="in/only-design.tsv"

# Delete existing design.out.gz
rm -f out/design.out.gz

run-adapt-with-metrics complete-targets auto-from-file $IN_TSV $OUT_TSV_DIR -gl $ARG_GL -gm $ARG_GM -gp $ARG_GP -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --id-m $ARG_IDM --id-frac $ARG_IDFRAC --id-method shard --require-flanking3 H --max-primers-at-site $ARG_MAXPRIMERSATSITE --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-target-length $ARG_MAXTARGETLENGTH --cost-fn-weights $ARG_COSTFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --predict-activity-model-path $PREDICTIVE_MODEL --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --cluster-threshold $CLUSTER_THRESHOLD --only-design-for $ONLY_DESIGN_FOR --write-input-seqs --write-input-aln --ncbi-api-key $NCBI_API_KEY --verbose &> out/design.out

# gzip the stdout/stderr
gzip out/design.out
