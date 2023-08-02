#!/bin/bash

# input file
# metadata file output from jupyter-lab with filtered sra reads to download
input_file="/storage/judit/BactCoviData/data/ec_filtered_d_sra.tsv"

# output directory
output_dir="/big-storage/judit/datasets/ecoli/reads/"

# create the output directory if it doesn't exist
mkdir -p "$output_dir"

# loop over each run ID in the input file
tail -n +2 "$input_file" | cut -f 1 | while read -r run_id; do
    # construct the output filename
    output_filename="${output_dir}${run_id}.fastq"

    # run the fasterq-dump command
    fasterq-dump "$run_id" -o "$output_filename" -e 12 -Z --skip-technical

    # print
    echo "Download completed for $run_id"
done
