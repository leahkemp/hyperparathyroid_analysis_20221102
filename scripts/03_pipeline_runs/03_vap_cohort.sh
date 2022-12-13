#!/bin/bash

# configure file paths
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# remove any old outputs of this script to avoid results being written twice to a file
rm -rf $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/
rm -rf $project_dir/logs/03_pipeline_runs/cohort/vcf_annotation_pipeline/

mkdir -p  $project_dir/logs/03_pipeline_runs/cohort/vcf_annotation_pipeline/

# get vcf_annotation_pipeline
echo ""
echo "Getting vcf_annotation_pipeline"
echo ""

cd $project_dir/results/03_pipeline_runs/cohort/
git clone https://github.com/ESR-NZ/vcf_annotation_pipeline.git
cd $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline
git checkout v1.1.0
cd $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/

# put my preprepared config files and runscripts in place to be used by the pipeline
echo ""
echo "Setting up pipeline config files"
echo ""

rsync $project_dir/config/03_pipeline_run/cohort/vcf_annotation_pipeline/cluster.json $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/config/
rsync $project_dir/config/03_pipeline_run/cohort/vcf_annotation_pipeline/config.yaml $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/config/
rsync $project_dir/config/03_pipeline_run/cohort/vcf_annotation_pipeline/dryrun_hpc.sh $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/
rsync $project_dir/config/03_pipeline_run/cohort/vcf_annotation_pipeline/run_hpc.sh $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/
rsync $project_dir/config/03_pipeline_run/cohort/vcf_annotation_pipeline/pbrun_vqsr_indel.smk $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/rules/
rsync $project_dir/config/03_pipeline_run/cohort/vcf_annotation_pipeline/pbrun_vqsr_snp.smk $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/rules/
rsync $project_dir/config/03_pipeline_run/cohort/vcf_annotation_pipeline/genmod.yaml $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/envs/
rsync $project_dir/config/03_pipeline_run/cohort/vcf_annotation_pipeline/Snakefile $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/

# set the shell to be used by conda for this script (and re-start shell to implement changes)
echo ""
echo "Configuring conda"
echo ""

conda init bash
source ~/.bashrc

# create conda environment with pipeline dependencies (mainly snakemake)
echo ""
echo "Creating conda environment with snakemake installed"
echo ""

mamba env create --force -f $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/pipeline_run_env.yml
conda activate pipeline_run_env

# run vcf_annotation_pipeline
echo ""
echo "Running vcf_annotation_pipeline"
echo ""

cd $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/
bash run_hpc.sh

# save pipeline run logs
cp $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/.snakemake/log/*.snakemake.log $project_dir/logs/03_pipeline_runs/cohort/vcf_annotation_pipeline/
cp -r $project_dir/results/03_pipeline_runs/cohort/vcf_annotation_pipeline/workflow/logs/* $project_dir/logs/03_pipeline_runs/cohort/vcf_annotation_pipeline/
rm $project_dir/logs/03_pipeline_runs/cohort/vcf_annotation_pipeline/README.md

cd $project_dir
