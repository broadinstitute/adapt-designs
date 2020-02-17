#!/bin/bash

# Load variables and other settings common to ADAPT runs.

# Find the path to the directory containing this script, relative to the pwd
COMMON_SCRIPTS_PATH=$( dirname "${BASH_SOURCE[0]}" )

# Load custom environment and variables
source $COMMON_SCRIPTS_PATH/custom-env/load_custom_env.sh

# Set and make the output directory
OUT_TSV_DIR="out/"
mkdir -p $OUT_TSV_DIR

# Make the memoize directory
mkdir -p $PREP_MEMOIZE_DIR

# Set tmp directory
export TMPDIR="/tmp"

# Set alias for running ADAPT's design.py and include metrics
alias run-adapt-with-metrics='/usr/bin/time -f "mem=%K RSS=%M elapsed=%e cpu.sys=%S .user=%U" design.py'

# Set parameters for design
CLUSTER_THRESHOLD="1.0"
ARG_GL="28"
ARG_GM="1"
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
