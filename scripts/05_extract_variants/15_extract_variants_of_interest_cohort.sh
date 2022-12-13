#!/bin/bash

#SBATCH --partition rocky8
#SBATCH --time=00:05:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="15_extract_variants_of_interest_cohort"
#SBATCH --output="./logs/05_extract_variants/slurm-%j-%x.out"

# configure project directory
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/05_extract_variants/cohort/CDKN1B_12_12871892_G_A.txt
rm -rf $project_dir/results/05_extract_variants/cohort/RET_10_43622368_T_A.txt

# make directory to put results in if it doesn't yet exist
mkdir -p $project_dir/results/05_extract_variants/cohort/

# extract some variants that we are particularly interested in
echo ""
echo "Extracting some variants we are particularly interested in"
echo ""

# gene CDKN1B
# chr12
# position 12871892
# change G-A
zgrep -v "##" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz | head -n 1 > $project_dir/results/05_extract_variants/cohort/CDKN1B_12_12871892_G_A.txt
zgrep "12871892" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz >> $project_dir/results/05_extract_variants/cohort/CDKN1B_12_12871892_G_A.txt

# rs2075913
# gene RET
# chr10
# position 43622368
# change T-A
zgrep -v "##" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz | head -n 1 > $project_dir/results/05_extract_variants/cohort/RET_10_43622368_T_A.txt
zgrep "rs2075913" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz >> $project_dir/results/05_extract_variants/cohort/RET_10_43622368_T_A.txt
