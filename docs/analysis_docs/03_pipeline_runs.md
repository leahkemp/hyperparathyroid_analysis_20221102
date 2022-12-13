# 03 - Pipeline runs

Created: 2022/11/02 14:26:44
Last modified: 2022/11/29 12:31:47

- **Aim:** This document documents/describes running pipelines on the data
- **Prerequisite software:** [GNU coreutils](https://www.gnu.org/software/coreutils/), [rsync](https://linux.die.net/man/1/rsync) v3.1.2, [git](https://git-scm.com/) v1.8.3.1, [conda](https://docs.conda.io/projects/conda/en/latest/index.html) v4.13.0, [mamba](https://mamba.readthedocs.io/en/latest/) v0.24.0, [parabricks](https://docs.nvidia.com/clara/parabricks/3.8.0/index.html) v3.8 and v3.7
- **OS:** ORAC (CentOS Linux) (ESR production network)

## Table of contents

- [03 - Pipeline runs](#03---pipeline-runs)
  - [Table of contents](#table-of-contents)
  - [Pipeline runs](#pipeline-runs)
    - [Singleton](#singleton)
    - [Cohort](#cohort)

## Pipeline runs

### Singleton

We want to run the pipelines on a priority sample (HP0041/22CG019) that the clinician is particularly interested in

Run bash script to run [human_genomics_pipeline](https://github.com/ESR-NZ/human_genomics_pipeline). See my script at [./scripts/03_pipeline_runs/01_hgp_singleton.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/03_pipeline_runs/01_hgp_singleton.sh)

```bash
bash ./scripts/03_pipeline_runs/01_hgp_singleton.sh
```

### Cohort

We also want to run all samples as a faux cohort, jointly calling variants so variants common among the patients can be evaluated

Run bash script to run [human_genomics_pipeline](https://github.com/ESR-NZ/human_genomics_pipeline). See my script at [./scripts/03_pipeline_runs/02_hgp_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/03_pipeline_runs/02_hgp_cohort.sh)

```bash
bash ./scripts/03_pipeline_runs/02_hgp_cohort.sh
```

*Note. I ended up getting errors with running pbrun triocombinegvcf on more than 3 files, so I modified the Snakefile to coerce the pipeline to run gatk CombineGVCFs instead. See the changes I made at [line 198 of ./config/03_pipeline_run/cohort/human_genomics_pipeline/Snakefile](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/config/03_pipeline_run/cohort/human_genomics_pipeline/Snakefile#L198)*

Run bash script to run [vcf_annotation_pipeline](https://github.com/ESR-NZ/vcf_annotation_pipeline). See my script at [./scripts/03_pipeline_runs/03_vap_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/03_pipeline_runs/03_vap_cohort.sh)

```bash
bash ./scripts/03_pipeline_runs/03_vap_cohort.sh
```
