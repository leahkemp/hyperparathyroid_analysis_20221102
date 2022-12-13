#!/bin/bash

#SBATCH --partition rocky8
#SBATCH --time=00:10:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="09_quick_dirty_grep_genes_of_interest_cohort"
#SBATCH --output="./logs/05_extract_variants/slurm-%j-%x.out"

# configure project directory
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/*

# make directory to put results in if it doesn't yet exist
mkdir -p $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/

# grep for variants in several genes that are of interest to the clinician because of their possible relevance to hyperparathyroidism
echo ""
echo "Grepping for variants in several genes"
echo ""

# generate a subset vcf file with varfiants from the list of genes of interest
singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "#" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-genes_of_interest.vcf

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep -e "|MEN1|" -e "|CDC73|" -e "|RET|" -e "|GCM2|" -e "|AP2S1|" -e "|GNA11|" -e "|CASR|" -e "|CDKN1A|" -e "|CDKN1B|" -e "|CDKN2B|" -e "|CDKN2C|" -e "|AIP|" -e "|CCND1|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz >> $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-genes_of_interest.vcf

# generate txt files with variants from each gene
singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|MEN1|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-MEN1-HGNC:7010.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|CDC73|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-CDC73-HGNC:16783.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|RET|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-RET-HGNC:9967.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|GCM2|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-GCM2-HGNC:4198.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|AP2S1|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-AP2S1-HGNC:565.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|GNA11|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-GNA11-HGNC:4379.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|CASR|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-CASR-HGNC:1514.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|CDKN1A|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-CDKN1A-HGNC:1784.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|CDKN1B|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-CDKN1B-HGNC:1785.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|CDKN2B|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-CDKN2B-HGNC:1788.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|CDKN2C|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-CDKN2C-HGNC:1789.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|AIP|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-AIP-HGNC:358.txt

singularity run \
-B $project_dir/results/ \
docker://ubuntu:rolling \
zgrep "|CCND1|" $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz > $project_dir/results/05_extract_variants/cohort/genes_quick_and_dirty_grep/21CG0001-CCND1-HGNC:1582.txt
