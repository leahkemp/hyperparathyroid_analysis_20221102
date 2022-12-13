# 08 - Cleanup

Created: 2022/11/17 14:50:49
Last modified: 2022/12/14 11:12:32

- **Aim:** This document documents/describes cleaning up
- **Prerequisite software:** [GNU coreutils](https://www.gnu.org/software/coreutils/), [singularity](https://docs.sylabs.io/guides/3.5/user-guide/index.html) v3.7.2-1.el7, [slurm](https://slurm.schedmd.com/overview.html) v20.11.6
- **OS:** ORAC (CentOS Linux) (ESR production network)

## Table of contents

- [08 - Cleanup](#08---cleanup)
  - [Table of contents](#table-of-contents)
  - [Cleanup](#cleanup)

## Cleanup

*Work in progress*

```bash
rm -r ./fastq/

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

rm -rf ./results/03_pipeline_runs/cohort/pedigrees/
```
