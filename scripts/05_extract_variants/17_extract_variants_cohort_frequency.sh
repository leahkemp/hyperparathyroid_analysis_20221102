#!/bin/bash

#SBATCH --partition rocky8
#SBATCH --time=00:30:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="17_extract_variants_cohort_frequency"
#SBATCH --output="./logs/05_extract_variants/slurm-%j-%x.out"

# configure project directory
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/05_extract_variants/cohort/cohort_frequency/*

# make directory to put results in if it doesn't yet exist
mkdir -p $project_dir/results/05_extract_variants/cohort/cohort_frequency/

# set the shell to be used by conda for this script (and re-start shell to implement changes)
echo ""
echo "Configuring conda"
echo ""

conda init bash
source ~/.bashrc

# create conda environment with vcftools installed
echo ""
echo "Creating conda environment with vcftools installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.vcftools.0.1.16.yml
conda activate vcftools

# extract variants present in all patients
echo ""
echo "Extracting variants present in all patients"
echo ""

vcftools \
--gzvcf $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--non-ref-af 1 \
--recode \
--recode-INFO-all \
--max-missing 1 \
--out $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_non_ref_no_missing_genotypes

vcftools \
--vcf $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf \
--non-ref-af 1 \
--recode \
--recode-INFO-all \
--max-missing 1 \
--out $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_non_ref_no_missing_genotypes_genes_of_interest

vcftools \
--gzvcf $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--non-ref-af 0 \
--recode \
--recode-INFO-all \
--max-missing 1 \
--out $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_ref_no_missing_genotypes

vcftools \
--vcf $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf \
--non-ref-af 0 \
--recode \
--recode-INFO-all \
--max-missing 1 \
--out $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_ref_no_missing_genotypes_genes_of_interest

# extract variants present in most patients
echo ""
echo "Extracting variants present in most patients"
echo ""

vcftools \
--gzvcf $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--non-ref-af 0.8-1 \
--recode \
--recode-INFO-all \
--max-missing 1 \
--out $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_non_ref_no_missing_genotypes

vcftools \
--vcf $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf \
--non-ref-af 0.8-1 \
--recode \
--recode-INFO-all \
--max-missing 1 \
--out $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_non_ref_no_missing_genotypes_genes_of_interest

vcftools \
--gzvcf $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz \
--non-ref-af 0-0.2 \
--recode \
--recode-INFO-all \
--max-missing 1 \
--out $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_ref_no_missing_genotypes

vcftools \
--vcf $project_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf \
--non-ref-af 0-0.2 \
--recode \
--recode-INFO-all \
--max-missing 1 \
--out $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_ref_no_missing_genotypes_genes_of_interest

# Merge vcf files
echo ""
echo "Merging vcf files"
echo ""

cat $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_non_ref_no_missing_genotypes.recode.vcf > $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_no_missing_genotypes.vcf
grep -v "#" $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_ref_no_missing_genotypes.recode.vcf >> $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_no_missing_genotypes.vcf

cat $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_non_ref_no_missing_genotypes_genes_of_interest.recode.vcf > $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_no_missing_genotypes_genes_of_interest.vcf
grep -v "#" $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_ref_no_missing_genotypes_genes_of_interest.recode.vcf >> $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_no_missing_genotypes_genes_of_interest.vcf

cat $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_non_ref_no_missing_genotypes.recode.vcf > $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_no_missing_genotypes.vcf
grep -v "#" $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_ref_no_missing_genotypes.recode.vcf >> $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_no_missing_genotypes.vcf

cat $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_non_ref_no_missing_genotypes_genes_of_interest.recode.vcf > $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_no_missing_genotypes_genes_of_interest.vcf
grep -v "#" $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_ref_no_missing_genotypes_genes_of_interest.recode.vcf >> $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_no_missing_genotypes_genes_of_interest.vcf

# cleaning up
echo ""
echo "Cleanup"
echo ""

rm $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_*.recode.vcf

# sort vcf
echo ""
echo "Sort vcf"
echo ""

for file in $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_*.vcf
do
    cat $file | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k2,2n"}' > $file.sorted
done

# cleanup
rm $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_*.vcf

# remove ".sorted" sufix
for file in $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_*.vcf.sorted
do
    mv "$file" "`echo $file | sed 's/.sorted//'`"
done

# create conda environment with htslib installed
echo ""
echo "Creating conda environment with htslib installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.htslib.1.10.2.yml
conda activate htslib

# compress vcf
echo ""
echo "Compressing vcf"
echo ""

bgzip $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_no_missing_genotypes.vcf
bgzip $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_no_missing_genotypes_genes_of_interest.vcf
bgzip $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_no_missing_genotypes.vcf
bgzip $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_no_missing_genotypes_genes_of_interest.vcf

# indexing vcf
echo ""
echo "Indexing vcf"
echo ""

tabix $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_no_missing_genotypes.vcf.gz
tabix $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_all_patients_no_missing_genotypes_genes_of_interest.vcf.gz
tabix $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_no_missing_genotypes.vcf.gz
tabix $project_dir/results/05_extract_variants/cohort/cohort_frequency/21CG0001_most_patients_no_missing_genotypes_genes_of_interest.vcf.gz

