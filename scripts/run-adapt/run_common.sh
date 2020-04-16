#!/bin/bash

# Load variables and other settings common to ADAPT runs.

# Find the absolute path to the directory containing this script
COMMON_SCRIPTS_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Load custom environment and variables
source $COMMON_SCRIPTS_PATH/custom-env/load_custom_env.sh

# Set and make the output directory
OUT_DIR="out/"
mkdir -p $OUT_DIR

# Make the memoize directory
mkdir -p $PREP_MEMOIZE_DIR

# Set tmp directory
export TMPDIR="/tmp"

# Set alias for running ADAPT's design.py
run-adapt() {
    # Delete existing design.out.gz
    rm -f $OUT_DIR/design.out.gz

    # Run with metrics
    /usr/bin/time -f "mem=%K RSS=%M elapsed=%e cpu.sys=%S .user=%U" design.py "$@" &> $OUT_DIR/design.out

    # gzip the stdout/stderr
    gzip $OUT_DIR/design.out

    # Write a timestamp indicating when the design completed
    timestamp=$(date +%s)
    echo "$timestamp" > $OUT_DIR/last-complete-timestamp
}

# Set parameters for design
CLUSTER_THRESHOLD="1.0"
ARG_GL="28"
ARG_GM="3"
ARG_GP="0.99"
ARG_PL="30"
ARG_PM="1"
ARG_PP="0.99"
ARG_PRIMER_GC_LO="0.4"
ARG_PRIMER_GC_HI="0.6"
ARG_IDM="4"
ARG_IDFRAC="0.01"
ARG_MAXPRIMERSATSITE="5"
ARG_MAXTARGETLENGTH="250"
ARG_COSTFNWEIGHTS="0.6667 0.2222 0.1111"
ARG_BESTNTARGETS="20"
ARG_PREDICTIVE_MODELS="${PREDICTIVE_MODELS_PATH}/classify/model-51373185 ${PREDICTIVE_MODELS_PATH}/regress/model-f8b6fd5d"
