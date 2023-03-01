#!/bin/bash

#SBATCH --partition prod
#SBATCH --time=02:00:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="03_post_processing_cohort"
#SBATCH --output="./logs/04_manual_annotation/slurm-%j-%x.out"

# configure directories
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm $project_dir/results/04_manual_annotation/cohort/*

# create output directories if they don't yet exist
mkdir -p $project_dir/results/04_manual_annotation/cohort/

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

# remove multiallelic sites
echo ""
echo "Removing multiallelic sites"
echo ""

bcftools view \
-O z \
--max-alleles 2 \
$project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/results/annotated/21CG0001_filtered_dbnsfp_vep_cadd_dbsnp_posteriors_denovo.vcf > $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_dbnsfp_vep_cadd_dbsnp_posteriors_denovo.multiallelicsites.vcf.gz

# create conda environment with gunzip installed
echo ""
echo "Creating conda environment with gunzip installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.gunzip.0.1.10.yml
conda activate gunzip

# remove multiallelic sites
echo ""
echo "Gunzipping vcf"
echo ""

gunzip < $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_dbnsfp_vep_cadd_dbsnp_posteriors_denovo.multiallelicsites.vcf.gz > $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_dbnsfp_vep_cadd_dbsnp_posteriors_denovo.multiallelicsites.vcf

# create conda environment with genmod installed
echo ""
echo "Creating conda environment with genmod installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.genmod.3.7.3.yml
conda activate genmod

# score variants
echo ""
echo "Scoring variants"
echo ""

genmod score \
$project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_dbnsfp_vep_cadd_dbsnp_posteriors_denovo.multiallelicsites.vcf \
--score_config $project_dir/config/04_manual_annotation/score_single.ini \
-o $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf

# sort by chromosome
echo ""
echo "Sorting by chromosome"
echo ""

cat $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k2,2n"}' > $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.sorted

# rename
cd $project_dir/results/04_manual_annotation/cohort/
rename -- .vcf.sorted .vcf 21CG0001_filtered_annotated_readyforscout.vcf.sorted
cd $project_dir

echo ""
echo "Fix rankscoring issue"
echo ""

# deal with rankscoring issue
sed -i 's/RankScore=1:/RankScore=21CG0001:/g' $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf

# create conda environment with htslib installed
echo ""
echo "Creating conda environment with htslib installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.htslib.1.10.2.yml
conda activate htslib

# compress and index vcf
echo ""
echo "Compressing and indexing vcf"
echo ""

bgzip $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf

# create conda environment with tabix installed
echo ""
echo "Creating conda environment with tabix installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.tabix.0.2.6.yml
conda activate tabix

tabix $project_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz
