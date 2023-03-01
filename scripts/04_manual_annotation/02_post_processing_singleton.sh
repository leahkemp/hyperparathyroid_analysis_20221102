#!/bin/bash

#SBATCH --partition prod
#SBATCH --time=02:00:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="02_post_processing_singleton"
#SBATCH --output="./logs/04_manual_annotation/slurm-%j-%x.out"

# configure directories
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"
public_data_dir="/NGS/clinicalgenomics/public_data"

# remove any old outputs of this script to avoid results being written twice to a file
rm $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.dbsnp.multiallelicsites.vcf.gz
rm $project_dir/results/04_manual_annotation/singleton/22CG019_filtered_annotated_readyforscout.vcf*

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
$project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.dbsnp.vcf.gz > $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.dbsnp.multiallelicsites.vcf.gz

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
$project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.dbsnp.multiallelicsites.vcf.gz \
--score_config $project_dir/config/04_manual_annotation/score_single.ini \
-o $project_dir/results/04_manual_annotation/singleton/22CG019_filtered_annotated_readyforscout.vcf

# sort by chromosome
echo ""
echo "Sorting by chromosome"
echo ""

cat $project_dir/results/04_manual_annotation/singleton/22CG019_filtered_annotated_readyforscout.vcf | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k2,2n"}' > $project_dir/results/04_manual_annotation/singleton/22CG019_filtered_annotated_readyforscout.vcf.sorted

# rename
cd $project_dir/results/04_manual_annotation/singleton/
rename -- .vcf.sorted .vcf 22CG019_filtered_annotated_readyforscout.vcf.sorted
cd $project_dir

echo ""
echo "Fix rankscoring issue"
echo ""

# deal with rankscoring issue
sed -i 's/RankScore=1:/RankScore=22CG019:/g' $project_dir/results/04_manual_annotation/singleton/22CG019_filtered_annotated_readyforscout.vcf

# create conda environment with htslib installed
echo ""
echo "Creating conda environment with htslib installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.htslib.1.10.2.yml
conda activate htslib

echo ""
echo "Compressing and indexing vcf"
echo ""

bgzip $project_dir/results/04_manual_annotation/singleton/22CG019_filtered_annotated_readyforscout.vcf

# create conda environment with tabix installed
echo ""
echo "Creating conda environment with tabix installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.tabix.0.2.6.yml
conda activate tabix

tabix $project_dir/results/04_manual_annotation/singleton/22CG019_filtered_annotated_readyforscout.vcf.gz
