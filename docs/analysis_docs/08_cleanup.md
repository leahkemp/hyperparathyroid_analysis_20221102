# 08 - Cleanup

Created: 2022/11/17 14:50:49
Last modified: 2023/02/08 12:54:58

- **Aim:** This document documents/describes cleaning up
- **Prerequisite software:** [GNU coreutils](https://www.gnu.org/software/coreutils/), [singularity](https://docs.sylabs.io/guides/3.5/user-guide/index.html) v3.7.2-1.el7, [slurm](https://slurm.schedmd.com/overview.html) v20.11.6
- **OS:** ORAC (CentOS Linux) (ESR production network)

## Table of contents

- [08 - Cleanup](#08---cleanup)
  - [Table of contents](#table-of-contents)
  - [Cleanup](#cleanup)

## Cleanup and backup

```bash
rm -r ./fastq/

rm -rf ./logs/

rm -rf ./scripts/

rm -rf ./config/

rm -rf ./docs/

rm .gitignore

rm -rf .git/

rm -rf ./results/03_pipeline_runs/cohort/fastq/
rm -rf ./results/03_pipeline_runs/singleton/fastq/

rm -rf ./results/03_pipeline_runs/*/*_pipeline/config/
rm -rf ./results/03_pipeline_runs/*/*_pipeline/workflow/
rm -rf ./results/03_pipeline_runs/*/*_pipeline/images/
rm -rf ./results/03_pipeline_runs/*/*_pipeline/docs/
rm -rf ./results/03_pipeline_runs/*/*_pipeline/test/
rm -rf ./results/03_pipeline_runs/*/*_pipeline/README.md

rm -rf ./results/03_pipeline_runs/*/*_pipeline/results/README.md
rm -rf ./results/03_pipeline_runs/*/human_genomics_pipeline/results/trimmed/
rm -rf ./results/03_pipeline_runs/*/human_genomics_pipeline/results/mapped/*_recalibrated_chrs.txt
rm -rf ./results/03_pipeline_runs/*/human_genomics_pipeline/results/qc/fastqc/
rm -rf ./results/03_pipeline_runs/*/human_genomics_pipeline/results/qc/multiqc_data/
rm -rf ./results/03_pipeline_runs/*/vcf_annotation_pipeline/results/annotated/*.txt
rm -rf ./results/03_pipeline_runs/*/human_genomics_pipeline/.git
rm -rf ./results/03_pipeline_runs/*/vcf_annotation_pipeline/git
rm -rf ./results/03_pipeline_runs/cohort/vcf_annotation_pipeline/
rm -rf ./results/03_pipeline_runs/cohort/human_genomics_pipeline/results/called/
rm -rf ./results/03_pipeline_runs/singleton/human_genomics_pipeline/results/called/
rm -rf ./results/03_pipeline_runs/cohort/pedigrees/

rm -rf ./results/04_manual_annotation/singleton/22CG019_raw_snps_indels*
rm -rf ./results/04_manual_annotation/cohort/21CG0001_filtered_dbnsfp_vep_cadd_dbsnp_posteriors_denovo.multiallelicsites.vcf*

```

Backup project

```bash
rsync -av /NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/ /NGS/clinicalgenomics/archive/2022/results/hyperparathyroid_analysis_20221102/
```
