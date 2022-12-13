#!/bin/bash

#SBATCH --partition rocky8
#SBATCH --time=00:10:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="13_extract_genes_of_interest_high_cadd_cohort"
#SBATCH --output="./logs/05_extract_variants/slurm-%j-%x.out"

# configure project directory
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/*

# make directory to put results in if it doesn't yet exist
mkdir -p $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/

# extract variants at various ranges of CADD score
echo ""
echo "Extracting variants at various ranges of CADD score from genes of interest"
echo ""

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'CADD=[1][0-9]' $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf > $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/21CG0001.genes_of_interest.cadd_10-19.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'CADD=[2][0-9]' $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf > $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/21CG0001.genes_of_interest.cadd_20-29.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'CADD=[3][0-9]' $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf > $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/21CG0001.genes_of_interest.cadd_30-39.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'CADD=[4][0-9]' $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf > $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/21CG0001.genes_of_interest.cadd_40-49.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'CADD=[5][0-9]' $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf > $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/21CG0001.genes_of_interest.cadd_50-59.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'CADD=[6][0-9]' $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf > $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/21CG0001.genes_of_interest.cadd_60-69.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'CADD=[7][0-9]' $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf > $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/21CG0001.genes_of_interest.cadd_70-79.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'CADD=[8][0-9]' $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf > $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/21CG0001.genes_of_interest.cadd_80-89.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'CADD=[9][0-9]' $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf > $project_dir/results/05_extract_variants/cohort/genes_of_interest_high_cadd/21CG0001.genes_of_interest.cadd_90-99.txt
