# 07 - Scout

Created: 2022/11/09 15:14:29
Last modified: 2023/01/19 14:32:36

- **Aim:** This document documents/describes setting up a [scout](http://www.clinicalgenomics.se/scout/) database for the CCDHB hyperparathyroidism exomes data (**ccdhb-exomes-database**)
- **Prerequisite software:** [rsync](https://rsync.samba.org/) v3.2.4, [Conda 4.12.0](https://docs.conda.io/projects/conda/en/latest/index.html), [Mamba 0.15.3](https://mamba.readthedocs.io/en/latest/index.html), [MonogDB v5.0.9](https://www.mongodb.com/)
- **OS:** Voldemort (Ubuntu 20.04.4 LTS) (ESR research network)

## Table of contents

- [07 - Scout](#07---scout)
  - [Table of contents](#table-of-contents)
  - [Get data](#get-data)
  - [Setup scout database](#setup-scout-database)
    - [Check mongoDB is running](#check-mongodb-is-running)
    - [Setup directories](#setup-directories)
    - [Create installation environment](#create-installation-environment)
    - [Installation](#installation)
    - [Create database](#create-database)
    - [Add users](#add-users)
    - [Populate database](#populate-database)
    - [Setup production server underneath scout](#setup-production-server-underneath-scout)
    - [Serve scout using production server](#serve-scout-using-production-server)
  - [Load cases into scout](#load-cases-into-scout)

## Get data

Create a bash variable with the directory you're working from for ease of use

```bash
working_dir=/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102
```

Transfer files to Voldemort

```bash
# run this code from Voldemort

# cohort
rsync -av orac:$working_dir/results/03_pipeline_runs/cohort/human_genomics_pipeline/results/mapped/*_recalibrated.bam* \
/data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/
rsync -av orac:$working_dir/results/05_extract_variants/cohort/genes_bed_extract/21CG0001_genes_of_interest.vcf \
/data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/vcf/

# singleton
rsync -av orac:$working_dir/results/04_manual_annotation/singleton/22CG019_filtered_annotated_readyforscout.vcf.gz* \
/data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/singleton/vcf/
rsync -av orac:$working_dir/results/03_pipeline_runs/singleton/human_genomics_pipeline/results/mapped/*_recalibrated.bam* \
/data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/singleton/bams/
```

## Setup scout database

### Check mongoDB is running

```bash
systemctl status mongod
```

<details><summary markdown="span">My output (click to expand)</summary>

```bash
○ mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
       Docs: https://docs.mongodb.org/manual
```

</details>
<br/>

Not running, so start mongod instance

```bash
systemctl start mongod
```

Now re-check mongoDB is running

```bash
systemctl status mongod
```

<details><summary markdown="span">My output (click to expand)</summary>

```bash
● mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; disabled; vendor preset: enabled)
     Active: active (running) since Mon 2023-01-16 12:06:08 NZDT; 45s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 117187 (mongod)
     Memory: 222.7M
        CPU: 1.507s
     CGroup: /system.slice/mongod.service
             └─117187 /usr/bin/mongod --config /etc/mongod.conf
```

</details>
<br/>

### Setup directories

```bash
mkdir -p /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/{cohort,singleton}/{bams,vcf}
mkdir -p /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/scout_load_configs/{cohort,singleton}
mkdir -p /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/server_config/
```

### Create installation environment

```bash
mamba create --name scout_env_ccdhb_exomes python=3.10.4
conda activate scout_env_ccdhb_exomes
```

<details><summary markdown="span">My output (click to expand)</summary>

```bash

                  __    __    __    __
                 /  \  /  \  /  \  /  \
                /    \/    \/    \/    \
███████████████/  /██/  /██/  /██/  /████████████████████████
              /  / \   / \   / \   / \  \____
             /  /   \_/   \_/   \_/   \    o \__,
            / _/                       \_____/  `
            |/
        ███╗   ███╗ █████╗ ███╗   ███╗██████╗  █████╗
        ████╗ ████║██╔══██╗████╗ ████║██╔══██╗██╔══██╗
        ██╔████╔██║███████║██╔████╔██║██████╔╝███████║
        ██║╚██╔╝██║██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║
        ██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║
        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝

        mamba (0.15.3) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████

WARNING: A conda environment already exists at '/home/lkemp/miniconda3/envs/scout_env_ccdhb_exomes'
Remove existing environment (y/[n])? y


Looking for: ['python=3.10.4']

bioconda/linux-64        Using cache
bioconda/noarch          Using cache
conda-forge/linux-64     Using cache
conda-forge/noarch       Using cache
pkgs/main/linux-64       [====================] (00m:00s) No change
pkgs/main/noarch         [====================] (00m:00s) No change
pkgs/r/linux-64          [====================] (00m:00s) No change
pkgs/r/noarch            [====================] (00m:00s) No change
Transaction

  Prefix: /home/lkemp/miniconda3/envs/scout_env_ccdhb_exomes

  Updating specs:

   - python=3.10.4


  Package               Version  Build               Channel                    Size
──────────────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────────────

  + _libgcc_mutex           0.1  conda_forge         conda-forge/linux-64     Cached
  + _openmp_mutex           4.5  2_gnu               conda-forge/linux-64     Cached
  + bzip2                 1.0.8  h7f98852_4          conda-forge/linux-64     Cached
  + ca-certificates   2022.12.7  ha878542_0          conda-forge/linux-64     Cached
  + ld_impl_linux-64       2.39  hcc3a1bd_1          conda-forge/linux-64     Cached
  + libffi                3.4.2  h7f98852_5          conda-forge/linux-64     Cached
  + libgcc-ng            12.2.0  h65d4601_19         conda-forge/linux-64     Cached
  + libgomp              12.2.0  h65d4601_19         conda-forge/linux-64     Cached
  + libnsl                2.0.0  h7f98852_0          conda-forge/linux-64     Cached
  + libsqlite            3.40.0  h753d276_0          conda-forge/linux-64     Cached
  + libuuid              2.32.1  h7f98852_1000       conda-forge/linux-64     Cached
  + libzlib              1.2.13  h166bdaf_4          conda-forge/linux-64     Cached
  + ncurses                 6.3  h27087fc_1          conda-forge/linux-64     Cached
  + openssl               3.0.7  h0b41bf4_1          conda-forge/linux-64     Cached
  + pip                  22.3.1  pyhd8ed1ab_0        conda-forge/noarch       Cached
  + python               3.10.4  h2660328_0_cpython  conda-forge/linux-64     Cached
  + readline              8.1.2  h0f457ee_0          conda-forge/linux-64     Cached
  + setuptools           65.6.3  pyhd8ed1ab_0        conda-forge/noarch       Cached
  + sqlite               3.40.0  h4ff8645_0          conda-forge/linux-64     Cached
  + tk                   8.6.12  h27826a3_0          conda-forge/linux-64     Cached
  + tzdata                2022g  h191b570_0          conda-forge/noarch       Cached
  + wheel                0.38.4  pyhd8ed1ab_0        conda-forge/noarch       Cached
  + xz                    5.2.6  h166bdaf_0          conda-forge/linux-64     Cached

  Summary:

  Install: 23 packages

  Total download: 0  B

──────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] y
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
#
# To activate this environment, use
#
#     $ conda activate scout_env_ccdhb_exomes
#
# To deactivate an active environment, use
#
#     $ conda deactivate

```

</details>
<br/>

### Installation

Will install the latest release, [scout v4.62.1](https://github.com/Clinical-Genomics/scout/tree/v4.62.1)

```bash
cd /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/
git clone https://github.com/Clinical-Genomics/scout
cd scout
git checkout v4.62.1
pip install --requirement requirements.txt --editable .
```

Check installation

```bash
scout --version
```

My output:

```bash
scout, version 4.62.1
```

Check installation location

```bash
which scout
```

My output:

```bash
/home/lkemp/miniconda3/bin/scout
```

### Create database

```bash
scout -db ccdhb-exomes-database setup database --api-key SECRET_KEY --institute-name CCDHB
```

### Add users

```bash
scout -db ccdhb-exomes-database load user -i CCDHB -u "Leah Kemp" -m leahmhkemp@gmail.com --admin
scout -db ccdhb-exomes-database load user -i CCDHB -u "Joep de ligt" -m joepio@gmail.com --admin
```

Also remove default user included in database

```bash
scout -db ccdhb-exomes-database delete user -m clark.kent@mail.com
```

### Populate database

```bash
scout -db ccdhb-exomes-database update genes --api-key SECRET_KEY
scout -db ccdhb-exomes-database update diseases --api-key SECRET_KEY
scout -db ccdhb-exomes-database update hpo --yes
scout -db ccdhb-exomes-database load exons
scout -db ccdhb-exomes-database load panel --panel-app --institute CCDHB
```

### Setup production server underneath scout

Install gunicorn

```bash
pip install gunicorn
```

<details><summary markdown="span">My output (click to expand)</summary>

```bash
Collecting gunicorn
  Using cached gunicorn-20.1.0-py3-none-any.whl (79 kB)
Requirement already satisfied: setuptools>=3.0 in /home/lkemp/miniconda3/envs/scout_env_ccdhb_exomes/lib/python3.10/site-packages (from gunicorn) (65.6.3)
Installing collected packages: gunicorn
Successfully installed gunicorn-20.1.0
```

</details>
<br/>

### Serve scout using production server

Serve in a screen so scout remains running. Also make sure conda env is activated.

```bash
screen -S scout_serve_ccdhb_exomes
conda activate scout_env_ccdhb_exomes
```

Create custom server config

```bash
touch /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/server_config/config.py
```

<details><summary markdown="span">My custom config file (click to expand)</summary>

```bash
# -*- coding: utf-8 -*-
SECRET_KEY = "this is not secret..."
REMEMBER_COOKIE_NAME = "scout_remember_me"  # Prevent session timeout when user closes browser
# SESSION_TIMEOUT_MINUTES = 60  # Minutes of inactivity before session times out

# MONGO_URI = "mongodb://127.0.0.1:27011,127.0.0.1:27012,127.0.0.1:27013/?replicaSet=rs0&readPreference=primary"
MONGO_DBNAME = "ccdhb-exomes-database"

BOOTSTRAP_SERVE_LOCAL = True
TEMPLATES_AUTO_RELOAD = True

DEBUG_TB_INTERCEPT_REDIRECTS = False

# Flask-mail: http://pythonhosted.org/flask-mail/
# see: https://bitbucket.org/danjac/flask-mail/issue/3
MAIL_SERVER = "smtp.gmail.com"
MAIL_PORT = 587
MAIL_USE_TLS = True
MAIL_USE_SSL = False

# Filename of accrediation bagde image in server/bluprints/public/static
# If null no badge is displayed in scout
ACCREDITATION_BADGE = "swedac-1926-iso17025.png"

# LDAP login Settings
# Complete list of accepted parameters available here: https://github.com/rroemhild/flask-ldapconn
# LDAP_HOST = "localhost" # Can also be named LDAP_SERVER
# LDAP_PORT = 389
# LDAP_BASE_DN = 'cn=admin,dc=example,dc=com # Can also be named LDAP_BINDDN
# LDAP_USER_LOGIN_ATTR = "mail" # Can also be named LDAP_SEARCH_ATTR
# LDAP_USE_SSL = False
# LDAP_USE_TLS = True

# Parameters required for Google Oauth 2.0 login
# GOOGLE = dict(
#    client_id="client.apps.googleusercontent.com",
#    client_secret="secret",
#    discovery_url="https://accounts.google.com/.well-known/openid-configuration",
# )

# Chanjo database connection string - used by chanjo report to create coverage reports
# SQLALCHEMY_DATABASE_URI = "mysql+pymysql://test_user:test_passwordw@127.0.0.1:3306/chanjo"

# Configure gens service
# GENS_HOST = "127.0.0.1"
# GENS_PORT = 5000

# Connection details for communicating with a rerunner service
# RERUNNER_API_ENTRYPOINT = "http://rerunner:5001/v1.0/rerun"
# RERUNNER_TIMEOUT = 10
# RERUNNER_API_KEY = "I am the Keymaster of Gozer"

# Matchmaker connection parameters
# - Tested with PatientMatcher (https://github.com/Clinical-Genomics/patientMatcher) -
# MME_ACCEPTS = "application/vnd.ga4gh.matchmaker.v1.0+json"
# MME_URL = "http://localhost:9020"
# MME_TOKEN = "DEMO"

# Beacon connection settings
# - Tested with cgbeacon2 (https://github.com/Clinical-Genomics/cgbeacon2) -
# BEACON_URL = "http://localhost:6000/apiv1.0"
# BEACON_TOKEN = "DEMO"

# connection details for LoqusDB MongoDB database
# Example with 2 instances of LoqusDB, one using a binary file and one instance connected via REST API
# When multiple instances are available, admin users can modify which one is in use for a given institute from the admin settings page
# LOQUSDB_SETTINGS = {
#    "default" : {"binary_path": "/miniconda3/envs/loqus2.5/bin/loqusdb", "config_path": "/home/user/settings/loqus_default.yaml"},
#    "loqus_api" : {"api_url": "http://127.0.0.1:9000"},
# }

#
# Cloud IGV tracks can be configured here to allow users to enable them on their IGV views.
# CLOUD_IGV_TRACKS = [
#    {
#        "name": "custom_public_bucket",
#        "access": "public",
#        "tracks": [
#            {
#                "name": "dbVar Pathogenic or Likely Pathogenic",
#                "type": "variant",
#                "format": "vcf",
#                "build": "37",
#                "url": "https://s3-eu-west-1.amazonaws.com/pfigshare-u-files/25777457/GRCh37.variant_call.clinical.pathogenic_or_likely_pathogenic.vcf.gz",
#                "indexURL": "https://s3-eu-west-1.amazonaws.com/pfigshare-u-files/25777460/GRCh37.variant_call.clinical.pathogenic_or_likely_pathogenic.vcf.gz.tbi",
#            }
#        ],
#    },
# ]

# Chanjo-Report
REPORT_LANGUAGE = "en"
ACCEPT_LANGUAGES = ["en", "sv"]

# TICKET_SYSTEM_EMAIL = "support@test_service.com"

# FEATURE FLAGS
SHOW_CAUSATIVES = True
SHOW_OBSERVED_VARIANT_ARCHIVE = True
HIDE_ALAMUT_LINK = True
# Display case rerun monitoring toggle
RERUN_MONITOR = True

# OMIM API KEY: Required for downloading definitions from OMIM (https://www.omim.org/api)
# OMIM_API_KEY = 'valid_omim_api_key'

# Parameters for enabling Phenomizer queries
# PHENOMIZER_USERNAME = "test_user"
# PHENOMIZER_PASSWORD = "test_password"

# Rank model link
RANK_MODEL_LINK_PREFIX = "https://raw.githubusercontent.com/Clinical-Genomics/reference-files/master/rare-disease/rank_model/rank_model_-v"
RANK_MODEL_LINK_POSTFIX = "-.ini"
SV_RANK_MODEL_LINK_PREFIX = "https://raw.githubusercontent.com/Clinical-Genomics/reference-files/master/rare-disease/rank_model/svrank_model_-v"
SV_RANK_MODEL_LINK_POSTFIX = "-.ini"

```

</details>
<br/>

## Load cases into scout

Create scout load config files

```bash
touch /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/scout_load_configs/singleton/22CG019_config.yaml
touch /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/scout_load_configs/cohort/21CG0001_config.yaml
```

<details><summary markdown="span">My scout case load config - singleton (click to expand)</summary>

```bash
---

owner: CCDHB

family: '22CG019'
samples:
  - analysis_type: wes
    sample_id: 22CG019
    father: 0
    mother: 0
    sample_name: 22CG019
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/singleton/bams/22CG019_recalibrated.bam

vcf_snv: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/singleton/vcf/22CG019_filtered_annotated_readyforscout.vcf.gz
analysis_date: 2022-11-28 12:24:20
human_genome_build: 37
```

</details>
<br/>

<details><summary markdown="span">My scout case load config - cohort (click to expand)</summary>

```bash
---

owner: CCDHB

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
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/21CG0001_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0002
    father: 0
    mother: 0
    sample_name: 21CG0002
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0002_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0003
    father: 0
    mother: 0
    sample_name: 21CG0003
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0003_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0004
    father: 0
    mother: 0
    sample_name: 21CG0004
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0004_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0005
    father: 0
    mother: 0
    sample_name: 21CG0005
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0005_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0006
    father: 0
    mother: 0
    sample_name: 21CG0006
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0006_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0007
    father: 0
    mother: 0
    sample_name: 21CG0007
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0007_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0008
    father: 0
    mother: 0
    sample_name: 21CG0008
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0008_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0009
    father: 0
    mother: 0
    sample_name: 21CG0009
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0009_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0010
    father: 0
    mother: 0
    sample_name: 21CG0010
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0010_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0011
    father: 0
    mother: 0
    sample_name: 21CG0011
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0011_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0012
    father: 0
    mother: 0
    sample_name: 21CG0012
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0012_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0013
    father: 0
    mother: 0
    sample_name: 21CG0013
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0013_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0014
    father: 0
    mother: 0
    sample_name: 21CG0014
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0014_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0015
    father: 0
    mother: 0
    sample_name: 21CG0015
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0015_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0016
    father: 0
    mother: 0
    sample_name: 21CG0016
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0016_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0017
    father: 0
    mother: 0
    sample_name: 21CG0017
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0017_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0018
    father: 0
    mother: 0
    sample_name: 21CG0018
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0018_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0019
    father: 0
    mother: 0
    sample_name: 21CG0019
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0019_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0020
    father: 0
    mother: 0
    sample_name: 21CG0020
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0020_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0021
    father: 0
    mother: 0
    sample_name: 21CG0021
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0021_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0034
    father: 0
    mother: 0
    sample_name: 21CG0034
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0034_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0035
    father: 0
    mother: 0
    sample_name: 21CG0035
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0035_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0036
    father: 0
    mother: 0
    sample_name: 21CG0036
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0036_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0037
    father: 0
    mother: 0
    sample_name: 21CG0037
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0037_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0038
    father: 0
    mother: 0
    sample_name: 21CG0038
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0038_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0039
    father: 0
    mother: 0
    sample_name: 21CG0039
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0039_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0040
    father: 0
    mother: 0
    sample_name: 21CG0040
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0040_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0041
    father: 0
    mother: 0
    sample_name: 21CG0041
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0041_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0042
    father: 0
    mother: 0
    sample_name: 21CG0042
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0042_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0043
    father: 0
    mother: 0
    sample_name: 21CG0043
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0043_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0044
    father: 0
    mother: 0
    sample_name: 21CG0044
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0044_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0045
    father: 0
    mother: 0
    sample_name: 21CG0045
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0045_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0046
    father: 0
    mother: 0
    sample_name: 21CG0046
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0046_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0047
    father: 0
    mother: 0
    sample_name: 21CG0047
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0047_recalibrated.bam

  - analysis_type: wes
    sample_id: 21CG0048
    father: 0
    mother: 0
    sample_name: 21CG0048
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG0048_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG001
    father: 0
    mother: 0
    sample_name: 22CG001
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG001_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG002
    father: 0
    mother: 0
    sample_name: 22CG002
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG002_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG003
    father: 0
    mother: 0
    sample_name: 22CG003
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG003_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG004
    father: 0
    mother: 0
    sample_name: 22CG004
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG004_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG005
    father: 0
    mother: 0
    sample_name: 22CG005
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG005_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG006
    father: 0
    mother: 0
    sample_name: 22CG006
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG006_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG007
    father: 0
    mother: 0
    sample_name: 22CG007
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG007_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG008
    father: 0
    mother: 0
    sample_name: 22CG008
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG008_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG009
    father: 0
    mother: 0
    sample_name: 22CG009
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG009_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG010
    father: 0
    mother: 0
    sample_name: 22CG010
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG010_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG011
    father: 0
    mother: 0
    sample_name: 22CG011
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG011_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG012
    father: 0
    mother: 0
    sample_name: 22CG012
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG012_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG013
    father: 0
    mother: 0
    sample_name: 22CG013
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG013_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG014
    father: 0
    mother: 0
    sample_name: 22CG014
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG014_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG015
    father: 0
    mother: 0
    sample_name: 22CG015
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG015_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG016
    father: 0
    mother: 0
    sample_name: 22CG016
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG016_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG017
    father: 0
    mother: 0
    sample_name: 22CG017
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG017_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG018
    father: 0
    mother: 0
    sample_name: 22CG018
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG018_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG019
    father: 0
    mother: 0
    sample_name: 22CG019
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG019_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG020
    father: 0
    mother: 0
    sample_name: 22CG020
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG020_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG021
    father: 0
    mother: 0
    sample_name: 22CG021
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG021_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG022
    father: 0
    mother: 0
    sample_name: 22CG022
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG022_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG023
    father: 0
    mother: 0
    sample_name: 22CG023
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG023_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG024
    father: 0
    mother: 0
    sample_name: 22CG024
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG024_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG025
    father: 0
    mother: 0
    sample_name: 22CG025
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG025_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG026
    father: 0
    mother: 0
    sample_name: 22CG026
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG026_recalibrated.bam

  - analysis_type: wes
    sample_id: 22CG027
    father: 0
    mother: 0
    sample_name: 22CG027
    phenotype: affected
    sex: unknown
    tissue_type: blood
    expected_coverage: 30
    bam_path: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/cohort/bams/22CG027_recalibrated.bam

vcf_snv: /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/data/singleton/vcf/21CG0001_genes_of_interest.vcf
analysis_date: 2022-11-28 12:24:20
human_genome_build: 37
```

</details>
<br/>

```bash
# singleton
scout -db ccdhb-exomes-database load case /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/scout_load_configs/singleton/22CG019_config.yaml
# cohort
scout -db ccdhb-exomes-database load case /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/scout_load_configs/cohort/21CG0001_config.yaml
```

Serve scout

```bash
cd /data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/scout/

SCOUT_CONFIG="/data/CCDHB_exomes_hyperparathyroid/ccdhb-exomes-database/server_config/config.py" \
gunicorn \
--workers=4 \
--bind="localhost:8500" \
scout.server.auto:app \
--timeout 300 \
--threads 4
```
