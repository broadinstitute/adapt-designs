#!/bin/bash

# Combine accession lists for NCBI and FASTA sequences from GISAID to
# create FASTAs for different taxonomic groupings.

# Load custom environment and variables; needed for conda
# loading for ADAPT
source ../../../scripts/run-adapt/custom-env/load_custom_env.sh

GISAID_DL_DATE="20200218"

# Delete fastas-for-design/ files already made
rm -f fastas-for-design/*

# Download sequences for NCBI accessions.
python ../../../scripts/download_fasta_for_accessions.py in/NCBI_SARS-CoV-1.acc.txt > /tmp/NCBI_SARS-CoV-1.fasta
python ../../../scripts/download_fasta_for_accessions.py in/NCBI_SARS-like.acc.txt > /tmp/NCBI_SARS-like.fasta

# Make the SARS-CoV-2 FASTA; this is directly from GISAID
cp in/GISAID_SARS-CoV-2.${GISAID_DL_DATE}.fasta fastas-for-design/SARS-CoV-2.fasta

# Make the SARS-like FASTA, combining GISAID and NCBI
cat /tmp/NCBI_SARS-like.fasta in/GISAID_SARS-like.${GISAID_DL_DATE}.fasta > fastas-for-design/SARS-like.fasta

# Make the SARS-CoV-1 FASTA; this is directly from NCBI
cp /tmp/NCBI_SARS-CoV-1.fasta fastas-for-design/SARS-CoV-1.fasta

# Make a complete SARS FASTA combining the disjoint groupings above
cat fastas-for-design/SARS-CoV-1.fasta fastas-for-design/SARS-like.fasta fastas-for-design/SARS-CoV-2.fasta > fastas-for-design/SARS-all.fasta

# gzip files
gzip fastas-for-design/SARS-CoV-2.fasta
gzip fastas-for-design/SARS-like.fasta
gzip fastas-for-design/SARS-CoV-1.fasta
gzip fastas-for-design/SARS-all.fasta

# Remove tmp files
rm /tmp/NCBI_SARS-CoV-1.fasta
rm /tmp/NCBI_SARS-like.fasta
