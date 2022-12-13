# 07 - Scout

Created: 2022/11/09 15:14:29
Last modified: 2022/12/14 11:12:26

- **Aim:** This document documents/describes setting up a scout instance and loading cases into it
- **Prerequisite software:**
- **OS:** Wintermute (Ubuntu 16.04.6 LTS) (ESR research network)

## Table of contents

- [07 - Scout](#07---scout)
  - [Table of contents](#table-of-contents)
  - [Setup scout database](#setup-scout-database)
    - [Check mongoDB is running](#check-mongodb-is-running)
    - [Setup directories](#setup-directories)
    - [Check existing scout installation](#check-existing-scout-installation)
    - [Serve scout using production server](#serve-scout-using-production-server)
  - [Load cases into scout](#load-cases-into-scout)

## Setup scout database

*Work in progress*

I'm going to use an existing scout database (**dhb-database** on Wintermute) to load this case into, because I need to wait until we have a new OMIM API key issued, which is required to load all the databases when creating a new scout instance

### Check mongoDB is running

```bash
systemctl status mongod
```

<details><summary markdown="span">My output (click to expand)</summary>

```bash
● mongod.service - MongoDB Database Server
   Loaded: loaded (/lib/systemd/system/mongod.service; disabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Mon 2022-11-28 11:08:08 NZDT; 49min ago
     Docs: https://docs.mongodb.org/manual
  Process: 26953 ExecStart=/usr/bin/mongod --config /etc/mongod.conf (code=exited, status=48)
 Main PID: 26953 (code=exited, status=48)
```

</details>
<br/>

### Setup directories

```bash
mkdir -p /data/lkemp/hyperparathyroid_scout/data/{bams,vcf}
mkdir -p /data/lkemp/hyperparathyroid_scout/scout_load_configs/
```

### Check existing scout installation

```bash
scout --version
```

My output:

```bash
sh: 0: getcwd() failed: No such file or directory
scout, version 4.27
```

Check installation location

```bash
which scout
```

My output:

```bash
/home/lkemp/anaconda3/envs/scout_env/bin/scout
```

### Serve scout using production server

Serve in a screen so scout remains running

Use screen already created and activate conda env with scout installed

```bash
screen -r -S scout_serve
conda activate scout_env
```

## Load cases into scout

Create a bash variable with the directory you're working from for ease of use

```bash
working_dir=/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102
```

Transfer files to Leviathan

```bash
/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/results/03_pipeline_runs/singleton/human_genomics_pipeline/results/mapped/22CG019_recalibrated.bam

/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz
# run this code from Leviathan
scp orac:$working_dir/results/03_pipeline_runs/singleton/human_genomics_pipeline/results/mapped/22CG019_recalibrated.bam /store/lkemp/hyperparathyroid_scout/data/bams/
scp orac:$working_dir/results/03_pipeline_runs/singleton/human_genomics_pipeline/results/mapped/22CG019_recalibrated.bam.bai /store/lkemp/hyperparathyroid_scout/data/bams/
scp orac:$working_dir/results/03_pipeline_runs/cohort/human_genomics_pipeline/results/mapped/*_recalibrated.bam /store/lkemp/hyperparathyroid_scout/data/bams/cohort/
scp orac:$working_dir/results/03_pipeline_runs/cohort/human_genomics_pipeline/results/mapped/*_recalibrated.bam.bai /store/lkemp/hyperparathyroid_scout/data/bams/cohort/
scp orac:$working_dir/results/04_manual_annotation/singleton/22CG019_filtered_annotated_readyforscout.vcf.gz /store/lkemp/hyperparathyroid_scout/data/vcf/
scp orac:$working_dir/results/04_manual_annotation/cohort/21CG0001_filtered_annotated_readyforscout.vcf.gz /store/lkemp/hyperparathyroid_scout/data/vcf/
```

Create scout load config files

```bash
touch /store/lkemp/hyperparathyroid_scout/scout_load_configs/22CG019_config.yaml
touch /store/lkemp/hyperparathyroid_scout/scout_load_configs/21CG0001_config.yaml
```

<details><summary markdown="span">My scout case load config - singleton (click to expand)</summary>

```bash
---

owner: DHB

family: '22CG019'
samples:
  - analysis_type: wgs
    sample_id: 22CG019
    father: 0
    mother: 0
    sample_name: 22CG019
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /store/lkemp/hyperparathyroid_scout/data/bams/22CG019_recalibrated.bam

vcf_snv: /store/lkemp/hyperparathyroid_scout/data/vcf/22CG019_filtered_annotated_readyforscout.vcf.gz
analysis_date: 2022-11-28 12:24:20
human_genome_build: GRCh37
```

</details>
<br/>

<details><summary markdown="span">My scout case load config - cohort (click to expand)</summary>

```bash
---

owner: DHB

family: '21CG0001'
samples:
  - analysis_type: wes
    sample_id: 21CG0001
    father: 0
    mother: 0
    sample_name: 21CG0001
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30

vcf_snv: /store/lkemp/hyperparathyroid_scout/data/vcf/21CG0001_filtered_annotated_readyforscout.vcf.gz
analysis_date: 2022-11-28 12:24:20
human_genome_build: GRCh37
```

</details>
<br/>

Load new cases into scout

```bash
# singleton
scout -db dhb-database load case /store/lkemp/hyperparathyroid_scout/scout_load_configs/22CG019_config.yaml
# cohort
scout -db dhb-database load case /store/lkemp/hyperparathyroid_scout/scout_load_configs/21CG0001_config.yaml
```

Re-serve scout

```bash
SCOUT_CONFIG="/store/lkemp/GA_clinical_genomics/server_config/config.py" gunicorn --workers=4 --bind="localhost:6500" scout.server.auto:app --timeout 360 --threads 4
```
