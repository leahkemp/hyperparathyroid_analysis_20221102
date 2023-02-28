# 04 - Manual annotation

Created: 2022/11/07 14:06:21
Last modified: 2023/02/28 15:12:32

- **Aim:** This document documents/describes the manual annotation of the data after the pipeline runs
- **Prerequisite software:** [GNU coreutils](https://www.gnu.org/software/coreutils/), [conda](https://docs.conda.io/projects/conda/en/latest/index.html) v4.13.0, [mamba](https://mamba.readthedocs.io/en/latest/) v0.24.0, [slurm](https://slurm.schedmd.com/overview.html) v20.11.6
- **OS:** ORAC (CentOS Linux) (ESR production network)

## Table of contents

- [04 - Manual annotation](#04---manual-annotation)
  - [Table of contents](#table-of-contents)
  - [Manual annotation](#manual-annotation)
    - [Singleton](#singleton)
    - [Cohort](#cohort)

## Manual annotation

### Singleton

For the sake of speed, I want to manually annotate the genes in the vcf files for the priority sample (HP0041/22CG019) that the clinician is particularly interested in. My aim is to annotate with the gene names so these can be grepped out, in case the vcf_annotation_pipeline errors out or takes too long. See my script at [./scripts/04_manual_annotation/01_manual_annotation_singleton.sh](https://github.com/leahkemp/hyperparathyroid_analysis_20221102/blob/main/scripts/04_manual_annotation/01_manual_annotation_singleton.sh)

```bash
sbatch ./scripts/04_manual_annotation/01_manual_annotation_singleton.sh
```

Post-processing (preparing for scout) of the singleton. See my script at [./scripts/04_manual_annotation/02_post_processing_singleton.sh](https://github.com/leahkemp/hyperparathyroid_analysis_20221102/blob/main/scripts/04_manual_annotation/02_post_processing_singleton.sh)

```bash
sbatch ./scripts/04_manual_annotation/02_post_processing_singleton.sh
```

### Cohort

Post-processing (preparing for scout) of the cohort. See my script at [./scripts/04_manual_annotation/02_post_processing_cohort.sh](https://github.com/leahkemp/hyperparathyroid_analysis_20221102/blob/main/scripts/04_manual_annotation/03_post_processing_cohort.sh)

```bash
sbatch ./scripts/04_manual_annotation/03_post_processing_cohort.sh
```
