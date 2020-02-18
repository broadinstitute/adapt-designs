#!/bin/bash

# Design panel.

source ../../../scripts/run-adapt/run_common.sh

# Set input
IN_TSV="in/taxa.tsv"

# Make accessions input file
# Note that taxonomy IDs this creates is only loosely correct (e.g., 114727=H1N1,
# yet this includes HanyN1); 99999999 is made-up for N{3,4,...}
ACCESSIONS_TO_USE="in/accessions-to-use.tsv"
cat ../../inputs/IAV.Hany-N1.segment6.acc.txt | grep . | awk '{print "114727\t6\t"$1}' > $ACCESSIONS_TO_USE
cat ../../inputs/IAV.Hany-N2.segment6.acc.txt | grep . | awk '{print "119210\t6\t"$1}' >> $ACCESSIONS_TO_USE
cat ../../inputs/IAV.Hany-Nnot1or2.segment6.acc.txt | grep . | awk '{print "99999999\t6\t"$1}' >> $ACCESSIONS_TO_USE

# Only design for N1 and N2
ONLY_DESIGN_FOR="in/only-design.tsv"

# Run the design
run-adapt design.py complete-targets auto-from-file $IN_TSV $OUT_TSV_DIR -gl $ARG_GL -gm $ARG_GM -gp $ARG_GP -pl $ARG_PL -pm $ARG_PM -pp $ARG_PP --id-m $ARG_IDM --id-frac $ARG_IDFRAC --id-method shard --require-flanking3 H --max-primers-at-site $ARG_MAXPRIMERSATSITE --primer-gc-content-bounds $ARG_PRIMER_GC_LO $ARG_PRIMER_GC_HI --max-target-length $ARG_MAXTARGETLENGTH --cost-fn-weights $ARG_COSTFNWEIGHTS --best-n-targets $ARG_BESTNTARGETS --predict-activity-model-path $PREDICTIVE_MODEL --mafft-path $MAFFT_PATH --prep-memoize-dir $PREP_MEMOIZE_DIR --cluster-threshold $CLUSTER_THRESHOLD --use-accessions $ACCESSIONS_TO_USE --only-design-for $ONLY_DESIGN_FOR --write-input-seqs --write-input-aln --ncbi-api-key $NCBI_API_KEY --verbose
