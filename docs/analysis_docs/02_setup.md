# 02 - Setup

Created: 2022/11/02 13:30:54
Last modified: 2023/03/02 13:30:00

- **Aim:** This document documents/describes setting up this project
- **Prerequisite software:** [GNU coreutils](https://www.gnu.org/software/coreutils/) v8.22, [slurm](https://slurm.schedmd.com/overview.html) v20.11.9
- **OS:** ORAC (CentOS Linux) (ESR production network)

## Table of contents

- [02 - Setup](#02---setup)
  - [Table of contents](#table-of-contents)
  - [Merge fastqs and format fastq file names](#merge-fastqs-and-format-fastq-file-names)

## Merge fastqs and format fastq file names

Run bash script to merge fastq files from different lanes and format the file names. See my script at [./scripts/02_setup/01_merge_fastq.sh](https://github.com/leahkemp/hyperparathyroid_analysis_20221102/blob/main/scripts/02_setup/01_merge_fastq.sh)

```bash
sbatch ./scripts/02_setup/01_merge_fastq.sh
```
