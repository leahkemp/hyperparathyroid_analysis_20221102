#!/bin/bash

#SBATCH --partition rocky8
#SBATCH --time=00:10:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="06_extract_genes_of_interest_high_rankscore_singleton"
#SBATCH --output="./logs/05_extract_variants/slurm-%j-%x.out"

# configure project directory
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/*

# make directory to put results in if it doesn't yet exist
mkdir -p $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/

# extract variants at various ranges of rankscore
echo ""
echo "Extracting variants at various ranges of rankscore from genes of interest"
echo ""

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:1' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_1.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:2' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_2.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:3' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_3.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:4' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_4.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:5' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_5.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:6' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_6.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:7' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_7.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:8' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_8.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:9' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_9.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -E 'RankScore=22CG019:10' $project_dir/results/05_extract_variants/singleton/genes_bed_extract/22CG019_genes_of_interest.vcf > $project_dir/results/05_extract_variants/singleton/genes_of_interest_high_rankscore/22CG019_genes_of_interest_rankscore_10.txt
