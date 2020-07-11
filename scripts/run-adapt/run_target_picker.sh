#!/bin/bash

# Load variables and other settings common to ADAPT runs.
#
# Args:
#   1: if set, only make test targets for this taxon
#   2: if set, minimum total fraction of sequences to cover
#      with the representative sequences (default: 0.99)
#   3: if set, maximum cluster distance at which to stop merging
#      (default: 0.01)

# Find the absolute path to the directory containing this script
COMMON_SCRIPTS_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Load custom environment and variables
source $COMMON_SCRIPTS_PATH/custom-env/load_custom_env.sh


# Set parameters for picking targets
ARG_PM="5"
ARG_GM="5"
ARG_MIN_TARGET_LEN="500"
if [ ! -z "$2" ]; then
    ARG_MIN_FRAC_TO_COVER_WITH_REP_SEQS="$2"
else
    ARG_MIN_FRAC_TO_COVER_WITH_REP_SEQS="0.99"
fi
if [ ! -z "$3" ]; then
    ARG_MAX_CLUSTER_DISTANCE="$3"
else
    ARG_MAX_CLUSTER_DISTANCE="0.01"
fi

# Run for each taxon
while read -r taxon_line; do
    taxon=$(echo "$taxon_line" | awk -F'\t' '{print $1}')

    # Check if this should only make test targets for a given taxon
    if [ ! -z "$1" ]; then
        if [ "$taxon" != "$1" ]; then
            echo "Skipping '$taxon'; only making test targets for '$1'"
            continue
        fi
    fi

    # Iterate over clusters, while a TSV file exists
    i=0
    while [ -f out/${taxon}.${i}.tsv ]; do
        design_tsv="out/${taxon}.${i}.tsv"
        alignment_fasta="out/${taxon}.${i}.fasta"
        test_targets_out="out/${taxon}.${i}.test-targets.tsv"

        pick_test_targets.py $design_tsv $alignment_fasta $test_targets_out -pm $ARG_PM -gm $ARG_GM --min-target-len $ARG_MIN_TARGET_LEN --min-frac-to-cover-with-rep-seqs $ARG_MIN_FRAC_TO_COVER_WITH_REP_SEQS --max-cluster-distance $ARG_MAX_CLUSTER_DISTANCE --verbose &> out/${taxon}.${i}.test-targets.out
        gzip -f out/${taxon}.${i}.test-targets.out

        i=$((i+1))
    done
done < in/taxa.tsv
