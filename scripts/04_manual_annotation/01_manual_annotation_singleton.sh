#!/bin/bash

#SBATCH --partition gpu
#SBATCH --time=24:00:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="01_manual_annotation_singleton"
#SBATCH --output="./logs/04_manual_annotation/slurm-%j-%x.out"

# configure directories
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"
public_data_dir="/NGS/humangenomics/active/2022/run/public_data"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/04_manual_annotation/singleton/

# make directory to put results in if it doesn't yet exist
mkdir -p $project_dir/results/04_manual_annotation/singleton/

# set the shell to be used by conda for this script (and re-start shell to implement changes)
echo ""
echo "Configuring conda"
echo ""

conda init bash
source ~/.bashrc

# create conda environment with gatk installed
echo ""
echo "Creating conda environment with gatk installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.gatk4.4.1.6.0.yml

# filter variants
echo ""
echo "Filtering variants"
echo ""

/opt/parabricks/3.6.1/parabricks/pbrun cnnscorevariants \
--in-vcf $project_dir/results/03_pipeline_runs/singleton/human_genomics_pipeline/results/called/22CG019_raw_snps_indels.vcf \
--in-bam $project_dir/results/03_pipeline_runs/singleton/human_genomics_pipeline/results/mapped/22CG019_recalibrated.bam \
--ref $public_data_dir/gatk_resource_bundle/b37/human_g1k_v37_decoy.fasta \
--out-vcf $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.scored.vcf \
--num-gpus 2

conda activate gatk4

gatk FilterVariantTranches \
-V $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.scored.vcf \
-O $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.vcf \
--snp-tranche 99.95 \
--indel-tranche 99.4 \
--tmp-dir /NGS/humangenomics/active/tmp/ \
--resource $public_data_dir/gatk_resource_bundle/b37/hapmap_3.3.b37.vcf \
--resource $public_data_dir/gatk_resource_bundle/b37/Mills_and_1000G_gold_standard.indels.b37.vcf \
--info-key CNN_2D

# create conda environment with snpsift installed
echo ""
echo "Creating conda environment with snpsift installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.snpsift.4.3.1.yml
conda activate snpsift

# annotate with dbNSFP
echo ""
echo "Annotating with dbNSFP"
echo ""

SnpSift -Xmx80g dbnsfp $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.vcf > $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vcf -db $public_data_dir/dbNSFP/GRCh37/dbNSFPv4.0a.hg19.custombuild.gz -v

# create conda environment with htslib installed
echo ""
echo "Creating conda environment with htslib installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.htslib.1.10.2.yml
conda activate htslib

# bgzip
echo ""
echo "bgzipping"
echo ""

bgzip < $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vcf > $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vcf.gz

# create conda environment with tabix installed
echo ""
echo "Creating conda environment with tabix installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.tabix.0.2.6.yml
conda activate tabix

# index
echo ""
echo "Indexing"
echo ""

tabix $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vcf.gz

# create conda environment with vep installed
echo ""
echo "Creating conda environment with vep installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.vep.99.2.yml
conda activate vep

# annotate with vep
echo ""
echo "Annotating with vep"
echo ""

vep -i $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vcf.gz \
--fasta $public_data_dir/gatk_resource_bundle/b37/human_g1k_v37_decoy.fasta \
--dir $public_data_dir/vep/GRCh37/ \
-o $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.vcf.gz \
--assembly GRCh37 \
--compress_output bgzip \
--cache \
 --offline \
 --stats_text \
 --everything \
 --vcf \
 --force_overwrite \
--fork 8

# create conda environment with genmod installed
echo ""
echo "Creating conda environment with genmod installed"
echo ""

mamba env create --force -f $project_dir/scripts/envs/conda.genmod.3.7.3.yml
conda activate genmod

# annotate with CADD
echo ""
echo "Annotating with CADD"
echo ""

genmod annotate $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.vcf.gz \
-c $public_data_dir/cadd/GRCh37/whole_genome_SNVs.tsv.gz \
-o $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.vcf

# annotate with dbSNP
echo ""
echo "Annotating with dbSNP"
echo ""

conda activate snpsift

SnpSift -Xmx80g annotate $public_data_dir/gatk_resource_bundle/b37/dbsnp_138.b37.vcf $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.vcf > $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.dbsnp.vcf

# index
echo ""
echo "Compressing and indexing vcf"
echo ""

conda activate htslib

bgzip < $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.dbsnp.vcf > $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.dbsnp.vcf.gz

conda activate tabix

tabix $project_dir/results/04_manual_annotation/singleton/22CG019_raw_snps_indels.filtered.dbnsfp.vep.cadd.dbsnp.vcf.gz
