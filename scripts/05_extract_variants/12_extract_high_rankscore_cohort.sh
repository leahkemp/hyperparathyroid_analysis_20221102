#!/bin/bash

#SBATCH --partition rocky8
#SBATCH --time=00:10:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="12_extract_high_rankscore_cohort"
#SBATCH --output="./logs/05_extract_variants/slurm-%j-%x.out"

# configure project directory
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/05_extract_variants/cohort/high_rankscore/*

# make directory to put results in if it doesn't yet exist
mkdir -p $project_dir/results/05_extract_variants/cohort/high_rankscore/

# extract variants at various ranges of rankscore
echo ""
echo "Extracting variants at various ranges of rankscore"
echo ""

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:1' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_1.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:2' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_2.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:3' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_3.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:4' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_4.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:5' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_5.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:6' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_6.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:7' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_7.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:8' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_8.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:9' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_9.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=21CG0001:10' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/high_rankscore/21CG0001_rankscore_10.txt
