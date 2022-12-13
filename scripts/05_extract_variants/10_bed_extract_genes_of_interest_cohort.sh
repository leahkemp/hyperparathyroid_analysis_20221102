#!/bin/bash

#SBATCH --partition rocky8
#SBATCH --time=00:10:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="10_bed_extract_genes_of_interest_cohort"
#SBATCH --output="./logs/05_extract_variants/slurm-%j-%x.out"

# configure project directory
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/05_extract_variants/cohort/genes_bed_extract/*

# make directory to put results in if it doesn't yet exist
mkdir -p $project_dir/results/05_extract_variants/cohort/genes_bed_extract/

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
echo "Extracting variants in several genes"
echo ""

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 11:64570982-64578766 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-MEN1-HGNC:7010.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 1:193091113-193223945 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-CDC73-HGNC:16783.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 10:43572512-43625799 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-RET-HGNC:9967.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 6:10873456-10882274 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-GCM2-HGNC:4198.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 19:47341393-47354103 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-AP2S1-HGNC:4198.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 19:3094360-3123997 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-GNA11-HGNC:4379.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 3:121902515-122010476 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-CASR-HGNC:1514.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 6:36644237-36655114 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-CDKN1A-HGNC:1784.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 12:12838432-12875303 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-CDKN1B-HGNC:1785.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 9:22002902-22009304 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-CDKN2B-HGNC:1788.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 1:51426417-51440306 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-CDKN2C-HGNC:1789.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 11:67235645-67258625 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-AIP-HGNC:358.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions 11:69455924-69469242 > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001-CCND1-HGNC:1582.vcf

bcftools view $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--regions-file $project_dir/config/05_extract_variants/genes_of_interest_hyperparathyroid.bed > $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf
