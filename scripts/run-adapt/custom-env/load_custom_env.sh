#!/bin/bash

# Set custom environmental variables

# Activate ADAPT conda environment
source ~/anaconda3/etc/profile.d/conda.sh
conda activate /ebs/dgd-analysis/tools/envs/adapt-prod

# Set a predictive model
# This is from commit da10963 of my adapt-seq-design repo
export PREDICTIVE_MODEL="/ebs/dgd-analysis/tools/adapt-seq-design-prod/models/predictor_exp-and-pos_regress-on-active/model-8f534a8c"

# Set API key
export NCBI_API_KEY="321e5004f2502f604ee2e8858a22b993d608"

# Set a path for memoizing designs
export PREP_MEMOIZE_DIR="/ebs/dgd-analysis/prep-memoize-dir"

# Set a path to MAFFT
export MAFFT_PATH="/home/hayden/viral-ngs/viral-ngs-etc/conda-env/bin/mafft"
