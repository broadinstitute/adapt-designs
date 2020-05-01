#!/bin/bash

# Combine accession lists for NCBI and FASTA sequences from GISAID to
# create FASTAs for different taxonomic groupings.

# The SARS-CoV-1-related and SARS-CoV-2-related groupings as are
# defined in Fig. 1 of https://www.nature.com/articles/s41586-020-2169-0
# They each include SARS-CoV-1 and SARS-CoV-2, as well as a subset of
# SARS-like sequences that are closely related to SARS-CoV-1 or
# SARS-CoV-2.

# Load custom environment and variables; needed for conda
# loading for ADAPT
source ../../../scripts/run-adapt/custom-env/load_custom_env.sh

GISAID_DL_DATE="20200428"

# Delete fastas-for-design/ files already made
rm -f fastas-for-design/*

# Download sequences for NCBI accessions.
python ../../../scripts/download_fasta_for_accessions.py in/NCBI_SARS-CoV-1.acc.txt > /tmp/NCBI_SARS-CoV-1.fasta
python ../../../scripts/download_fasta_for_accessions.py in/NCBI_SARS-like.SARS-CoV-1_related.acc.txt > /tmp/NCBI_SARS-like.SARS-CoV-1_related.fasta
python ../../../scripts/download_fasta_for_accessions.py in/NCBI_SARS-like.SARS-CoV-2_related.acc.txt > /tmp/NCBI_SARS-like.SARS-CoV-2_related.fasta
python ../../../scripts/download_fasta_for_accessions.py in/NCBI_SARS-like.SARS-CoV-2_related_trimmed.acc.txt > /tmp/NCBI_SARS-like.SARS-CoV-2_related_trimmed.fasta
python ../../../scripts/download_fasta_for_accessions.py in/NCBI_SARS-like.other.acc.txt > /tmp/NCBI_SARS-like.other.fasta

# Make the SARS-CoV-2 FASTA; this is directly from GISAID
cp in/GISAID_SARS-CoV-2.${GISAID_DL_DATE}.fasta fastas-for-design/SARS-CoV-2.fasta

# Make the SARS-CoV-2-related FASTA, combining GISAID and NCBI
# This includes SARS-CoV-2 and SARS-like sequences that are closely related
# All SARS-like from GISAID is SARS-CoV-2-related
cat /tmp/NCBI_SARS-like.SARS-CoV-2_related.fasta in/GISAID_SARS-like.${GISAID_DL_DATE}.fasta in/GISAID_SARS-CoV-2.${GISAID_DL_DATE}.fasta > fastas-for-design/SARS-CoV-2-related.fasta

# Make a FASTA that is like SARS-CoV-2-related, except without SARS-CoV-2 and a few sequences highly similar to SARS-CoV-2
cat /tmp/NCBI_SARS-like.SARS-CoV-2_related_trimmed.fasta in/GISAID_SARS-like_trimmed.${GISAID_DL_DATE}.fasta > /tmp/SARS-CoV-2-related_without_SARS-CoV-2_and_surrounding.fasta

# Make the SARS-CoV-1 FASTA; this is directly from NCBI
cp /tmp/NCBI_SARS-CoV-1.fasta fastas-for-design/SARS-CoV-1.fasta

# Make the SARS-CoV-1-related FASTA, from NCBI
# This includes SARS-CoV-1 and SARS-like sequences that are closely related
cat /tmp/NCBI_SARS-like.SARS-CoV-1_related.fasta /tmp/NCBI_SARS-CoV-1.fasta > fastas-for-design/SARS-CoV-1-related.fasta

# Make a full SARS-like FASTA
cat /tmp/NCBI_SARS-like.SARS-CoV-1_related.fasta /tmp/NCBI_SARS-like.SARS-CoV-2_related.fasta /tmp/NCBI_SARS-like.other.fasta in/GISAID_SARS-like.${GISAID_DL_DATE}.fasta > fastas-for-design/SARS-like.fasta

# Make a SARS FASTA that has everything except SARS-CoV-2 and sequences that are highly related to SARS-CoV-2 (RaTG13 and a pangolin sequence, GD/P1L)
cat fastas-for-design/SARS-CoV-1.fasta /tmp/NCBI_SARS-like.SARS-CoV-1_related.fasta /tmp/NCBI_SARS-like.other.fasta /tmp/SARS-CoV-2-related_without_SARS-CoV-2_and_surrounding.fasta > fastas-for-design/SARS-CoV-2_loose-surrounding.fasta

# Make a complete SARS FASTA combining the disjoint groupings above
cat fastas-for-design/SARS-CoV-1.fasta fastas-for-design/SARS-like.fasta fastas-for-design/SARS-CoV-2.fasta > fastas-for-design/SARS-all.fasta

# gzip files
gzip fastas-for-design/SARS-CoV-2.fasta
gzip fastas-for-design/SARS-CoV-2-related.fasta
gzip fastas-for-design/SARS-CoV-1.fasta
gzip fastas-for-design/SARS-CoV-1-related.fasta
gzip fastas-for-design/SARS-like.fasta
gzip fastas-for-design/SARS-all.fasta
gzip fastas-for-design/SARS-CoV-2_loose-surrounding.fasta

# Remove tmp files
rm /tmp/NCBI_SARS-CoV-1.fasta
rm /tmp/NCBI_SARS-like.SARS-CoV-1_related.fasta
rm /tmp/NCBI_SARS-like.SARS-CoV-2_related.fasta
rm /tmp/SARS-CoV-2-related_without_SARS-CoV-2_and_surrounding.fasta
rm /tmp/NCBI_SARS-like.other.fasta
