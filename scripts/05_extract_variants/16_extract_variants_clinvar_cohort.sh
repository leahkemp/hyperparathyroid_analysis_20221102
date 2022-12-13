#!/bin/bash

#SBATCH --partition rocky8
#SBATCH --time=00:10:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="16_extract_variants_clinvar_cohort"
#SBATCH --output="./logs/05_extract_variants/slurm-%j-%x.out"

# configure project directory
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/05_extract_variants/cohort/clinvar/*

# make directory to put results in if it doesn't yet exist
mkdir -p $project_dir/results/05_extract_variants/cohort/clinvar/

# set the shell to be used by conda for this script (and re-start shell to implement changes)
echo ""
echo "Configuring conda"
echo ""

conda init bash
source ~/.bashrc

# create conda environment with bcftools installed
echo ""
echo "Creating conda environment with bcftools installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.bcftools.1.16.yml
conda activate bcftools

# extract variants in several genes that are of interest to the clinician because of their possible relevance to hyperparathyroidism
echo ""
echo "Extracting clinvar variants"
echo ""

mkdir -p $project_dir/results/05_extract_variants/cohort/clinvar/

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions-file $project_dir/config/05_extract_variants/clinvar_endocrine_pathogenic_multiple_submitters_snp.bed > $project_dir/results/05_extract_variants/cohort/clinvar/21CG0001_clinvar_endocrine_pathogenic_multiple_submitters_snp.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions-file $project_dir/config/05_extract_variants/clinvar_hyperparathyroidism_pathogenic_multiple_submitters_snp.bed > $project_dir/results/05_extract_variants/cohort/clinvar/21CG0001_clinvar_hyperparathyroidism_pathogenic_multiple_submitters_snp.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions-file $project_dir/config/05_extract_variants/clinvar_hyperparathyroidism_likely_pathogenic_multiple_submitters_snp.bed > $project_dir/results/05_extract_variants/cohort/clinvar/21CG0001_clinvar_hyperparathyroidism_likely_pathogenic_multiple_submitters_snp.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions-file $project_dir/config/05_extract_variants/clinvar_hyperparathyroidism_pathogenic_snp.bed > $project_dir/results/05_extract_variants/cohort/clinvar/21CG0001_clinvar_hyperparathyroidism_pathogenic_snp.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions-file $project_dir/config/05_extract_variants/clinvar_hyperparathyroidism_likely_pathogenic_snp.bed > $project_dir/results/05_extract_variants/cohort/clinvar/21CG0001_clinvar_hyperparathyroidism_likely_pathogenic_snp.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions-file $project_dir/config/05_extract_variants/clinvar_genes_of_interest_pathogenic_multiple_submitters_snp.bed > $project_dir/results/05_extract_variants/cohort/clinvar/21CG0001_clinvar_genes_of_interest_pathogenic_multiple_submitters_snp.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions-file $project_dir/config/05_extract_variants/clinvar_genes_of_interest_likely_pathogenic_multiple_submitters_snp.bed > $project_dir/results/05_extract_variants/cohort/clinvar/21CG0001_clinvar_genes_of_interest_likely_pathogenic_multiple_submitters_snp.vcf
