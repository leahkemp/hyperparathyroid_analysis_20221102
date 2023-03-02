# 01 - Assumptions

Created: 2022/11/02 11:21:46
Last modified: 2023/03/02 13:27:31

- **Aim:** This document documents/describes the assumptions for reproducing this analysis
- **Prerequisite software:**
- **OS:**

## Table of contents

- [01 - Assumptions](#01---assumptions)
  - [Table of contents](#table-of-contents)
  - [Assumptions](#assumptions)

## Assumptions

1. You have cloned the [project github repository](https://github.com/leahkemp/hyperparathyroid_analysis_20221102) and are running all code from this directory

2. You have configured all user configurable parameters within each script appropriate for your setup

3. You have the mentioned prerequisite software

4. You have raw fastq files in a single directory named `fastq` within the project directory

<details><summary markdown="span">Expected raw fastq files (click to expand)</summary>

```bash
/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/fastq
├── [855M]  21CG0001_S1_L001_R1_001.fastq.gz
├── [884M]  21CG0001_S1_L001_R2_001.fastq.gz
├── [824M]  21CG0001_S1_L002_R1_001.fastq.gz
├── [852M]  21CG0001_S1_L002_R2_001.fastq.gz
├── [872M]  21CG0001_S1_L003_R1_001.fastq.gz
├── [902M]  21CG0001_S1_L003_R2_001.fastq.gz
├── [837M]  21CG0001_S1_L004_R1_001.fastq.gz
├── [870M]  21CG0001_S1_L004_R2_001.fastq.gz
├── [852M]  21CG0002_S2_L001_R1_001.fastq.gz
├── [853M]  21CG0002_S2_L001_R2_001.fastq.gz
├── [821M]  21CG0002_S2_L002_R1_001.fastq.gz
├── [823M]  21CG0002_S2_L002_R2_001.fastq.gz
├── [869M]  21CG0002_S2_L003_R1_001.fastq.gz
├── [870M]  21CG0002_S2_L003_R2_001.fastq.gz
├── [834M]  21CG0002_S2_L004_R1_001.fastq.gz
├── [842M]  21CG0002_S2_L004_R2_001.fastq.gz
├── [779M]  21CG0003_S3_L001_R1_001.fastq.gz
├── [780M]  21CG0003_S3_L001_R2_001.fastq.gz
├── [749M]  21CG0003_S3_L002_R1_001.fastq.gz
├── [751M]  21CG0003_S3_L002_R2_001.fastq.gz
├── [794M]  21CG0003_S3_L003_R1_001.fastq.gz
├── [796M]  21CG0003_S3_L003_R2_001.fastq.gz
├── [763M]  21CG0003_S3_L004_R1_001.fastq.gz
├── [770M]  21CG0003_S3_L004_R2_001.fastq.gz
├── [825M]  21CG0004_S4_L001_R1_001.fastq.gz
├── [837M]  21CG0004_S4_L001_R2_001.fastq.gz
├── [795M]  21CG0004_S4_L002_R1_001.fastq.gz
├── [806M]  21CG0004_S4_L002_R2_001.fastq.gz
├── [842M]  21CG0004_S4_L003_R1_001.fastq.gz
├── [855M]  21CG0004_S4_L003_R2_001.fastq.gz
├── [806M]  21CG0004_S4_L004_R1_001.fastq.gz
├── [824M]  21CG0004_S4_L004_R2_001.fastq.gz
├── [723M]  21CG0005_S5_L001_R1_001.fastq.gz
├── [724M]  21CG0005_S5_L001_R2_001.fastq.gz
├── [673M]  21CG0005_S5_L002_R1_001.fastq.gz
├── [677M]  21CG0005_S5_L002_R2_001.fastq.gz
├── [735M]  21CG0005_S5_L003_R1_001.fastq.gz
├── [737M]  21CG0005_S5_L003_R2_001.fastq.gz
├── [687M]  21CG0005_S5_L004_R1_001.fastq.gz
├── [695M]  21CG0005_S5_L004_R2_001.fastq.gz
├── [892M]  21CG0006_S6_L001_R1_001.fastq.gz
├── [891M]  21CG0006_S6_L001_R2_001.fastq.gz
├── [860M]  21CG0006_S6_L002_R1_001.fastq.gz
├── [860M]  21CG0006_S6_L002_R2_001.fastq.gz
├── [906M]  21CG0006_S6_L003_R1_001.fastq.gz
├── [905M]  21CG0006_S6_L003_R2_001.fastq.gz
├── [869M]  21CG0006_S6_L004_R1_001.fastq.gz
├── [875M]  21CG0006_S6_L004_R2_001.fastq.gz
├── [834M]  21CG0007_S7_L001_R1_001.fastq.gz
├── [838M]  21CG0007_S7_L001_R2_001.fastq.gz
├── [799M]  21CG0007_S7_L002_R1_001.fastq.gz
├── [804M]  21CG0007_S7_L002_R2_001.fastq.gz
├── [851M]  21CG0007_S7_L003_R1_001.fastq.gz
├── [857M]  21CG0007_S7_L003_R2_001.fastq.gz
├── [813M]  21CG0007_S7_L004_R1_001.fastq.gz
├── [824M]  21CG0007_S7_L004_R2_001.fastq.gz
├── [760M]  21CG0008_S8_L001_R1_001.fastq.gz
├── [767M]  21CG0008_S8_L001_R2_001.fastq.gz
├── [729M]  21CG0008_S8_L002_R1_001.fastq.gz
├── [738M]  21CG0008_S8_L002_R2_001.fastq.gz
├── [774M]  21CG0008_S8_L003_R1_001.fastq.gz
├── [782M]  21CG0008_S8_L003_R2_001.fastq.gz
├── [740M]  21CG0008_S8_L004_R1_001.fastq.gz
├── [754M]  21CG0008_S8_L004_R2_001.fastq.gz
├── [1.4G]  21CG0009_S1_L001_R1_001.fastq.gz
├── [1.4G]  21CG0009_S1_L001_R2_001.fastq.gz
├── [1.4G]  21CG0009_S1_L002_R1_001.fastq.gz
├── [1.4G]  21CG0009_S1_L002_R2_001.fastq.gz
├── [1.4G]  21CG0009_S1_L003_R1_001.fastq.gz
├── [1.4G]  21CG0009_S1_L003_R2_001.fastq.gz
├── [1.4G]  21CG0009_S1_L004_R1_001.fastq.gz
├── [1.4G]  21CG0009_S1_L004_R2_001.fastq.gz
├── [1.4G]  21CG0010_S2_L001_R1_001.fastq.gz
├── [1.4G]  21CG0010_S2_L001_R2_001.fastq.gz
├── [1.4G]  21CG0010_S2_L002_R1_001.fastq.gz
├── [1.4G]  21CG0010_S2_L002_R2_001.fastq.gz
├── [1.5G]  21CG0010_S2_L003_R1_001.fastq.gz
├── [1.5G]  21CG0010_S2_L003_R2_001.fastq.gz
├── [1.4G]  21CG0010_S2_L004_R1_001.fastq.gz
├── [1.4G]  21CG0010_S2_L004_R2_001.fastq.gz
├── [1.1G]  21CG0011_S3_L001_R1_001.fastq.gz
├── [1.1G]  21CG0011_S3_L001_R2_001.fastq.gz
├── [1.1G]  21CG0011_S3_L002_R1_001.fastq.gz
├── [1.1G]  21CG0011_S3_L002_R2_001.fastq.gz
├── [1.1G]  21CG0011_S3_L003_R1_001.fastq.gz
├── [1.1G]  21CG0011_S3_L003_R2_001.fastq.gz
├── [1.1G]  21CG0011_S3_L004_R1_001.fastq.gz
├── [1.1G]  21CG0011_S3_L004_R2_001.fastq.gz
├── [1.5G]  21CG0012_S4_L001_R1_001.fastq.gz
├── [1.5G]  21CG0012_S4_L001_R2_001.fastq.gz
├── [1.5G]  21CG0012_S4_L002_R1_001.fastq.gz
├── [1.4G]  21CG0012_S4_L002_R2_001.fastq.gz
├── [1.5G]  21CG0012_S4_L003_R1_001.fastq.gz
├── [1.5G]  21CG0012_S4_L003_R2_001.fastq.gz
├── [1.5G]  21CG0012_S4_L004_R1_001.fastq.gz
├── [1.5G]  21CG0012_S4_L004_R2_001.fastq.gz
├── [1.3G]  21CG0013_S5_L001_R1_001.fastq.gz
├── [1.3G]  21CG0013_S5_L001_R2_001.fastq.gz
├── [1.2G]  21CG0013_S5_L002_R1_001.fastq.gz
├── [1.2G]  21CG0013_S5_L002_R2_001.fastq.gz
├── [1.3G]  21CG0013_S5_L003_R1_001.fastq.gz
├── [1.3G]  21CG0013_S5_L003_R2_001.fastq.gz
├── [1.2G]  21CG0013_S5_L004_R1_001.fastq.gz
├── [1.2G]  21CG0013_S5_L004_R2_001.fastq.gz
├── [1.6G]  21CG0014_S6_L001_R1_001.fastq.gz
├── [1.6G]  21CG0014_S6_L001_R2_001.fastq.gz
├── [1.5G]  21CG0014_S6_L002_R1_001.fastq.gz
├── [1.5G]  21CG0014_S6_L002_R2_001.fastq.gz
├── [1.6G]  21CG0014_S6_L003_R1_001.fastq.gz
├── [1.6G]  21CG0014_S6_L003_R2_001.fastq.gz
├── [1.5G]  21CG0014_S6_L004_R1_001.fastq.gz
├── [1.6G]  21CG0014_S6_L004_R2_001.fastq.gz
├── [1.4G]  21CG0015_S7_L001_R1_001.fastq.gz
├── [1.4G]  21CG0015_S7_L001_R2_001.fastq.gz
├── [1.3G]  21CG0015_S7_L002_R1_001.fastq.gz
├── [1.3G]  21CG0015_S7_L002_R2_001.fastq.gz
├── [1.4G]  21CG0015_S7_L003_R1_001.fastq.gz
├── [1.4G]  21CG0015_S7_L003_R2_001.fastq.gz
├── [1.3G]  21CG0015_S7_L004_R1_001.fastq.gz
├── [1.3G]  21CG0015_S7_L004_R2_001.fastq.gz
├── [1.4G]  21CG0016_S8_L001_R1_001.fastq.gz
├── [1.4G]  21CG0016_S8_L001_R2_001.fastq.gz
├── [1.3G]  21CG0016_S8_L002_R1_001.fastq.gz
├── [1.3G]  21CG0016_S8_L002_R2_001.fastq.gz
├── [1.4G]  21CG0016_S8_L003_R1_001.fastq.gz
├── [1.4G]  21CG0016_S8_L003_R2_001.fastq.gz
├── [1.3G]  21CG0016_S8_L004_R1_001.fastq.gz
├── [1.3G]  21CG0016_S8_L004_R2_001.fastq.gz
├── [1.4G]  21CG0017_S1_L001_R1_001.fastq.gz
├── [1.4G]  21CG0017_S1_L001_R2_001.fastq.gz
├── [1.4G]  21CG0017_S1_L002_R1_001.fastq.gz
├── [1.4G]  21CG0017_S1_L002_R2_001.fastq.gz
├── [1.5G]  21CG0017_S1_L003_R1_001.fastq.gz
├── [1.4G]  21CG0017_S1_L003_R2_001.fastq.gz
├── [1.4G]  21CG0017_S1_L004_R1_001.fastq.gz
├── [1.4G]  21CG0017_S1_L004_R2_001.fastq.gz
├── [1.5G]  21CG0018_S2_L001_R1_001.fastq.gz
├── [1.5G]  21CG0018_S2_L001_R2_001.fastq.gz
├── [1.4G]  21CG0018_S2_L002_R1_001.fastq.gz
├── [1.4G]  21CG0018_S2_L002_R2_001.fastq.gz
├── [1.5G]  21CG0018_S2_L003_R1_001.fastq.gz
├── [1.5G]  21CG0018_S2_L003_R2_001.fastq.gz
├── [1.4G]  21CG0018_S2_L004_R1_001.fastq.gz
├── [1.4G]  21CG0018_S2_L004_R2_001.fastq.gz
├── [1.5G]  21CG0019_S3_L001_R1_001.fastq.gz
├── [1.5G]  21CG0019_S3_L001_R2_001.fastq.gz
├── [1.4G]  21CG0019_S3_L002_R1_001.fastq.gz
├── [1.4G]  21CG0019_S3_L002_R2_001.fastq.gz
├── [1.5G]  21CG0019_S3_L003_R1_001.fastq.gz
├── [1.5G]  21CG0019_S3_L003_R2_001.fastq.gz
├── [1.4G]  21CG0019_S3_L004_R1_001.fastq.gz
├── [1.4G]  21CG0019_S3_L004_R2_001.fastq.gz
├── [1.5G]  21CG0020_S4_L001_R1_001.fastq.gz
├── [1.6G]  21CG0020_S4_L001_R2_001.fastq.gz
├── [1.5G]  21CG0020_S4_L002_R1_001.fastq.gz
├── [1.5G]  21CG0020_S4_L002_R2_001.fastq.gz
├── [1.6G]  21CG0020_S4_L003_R1_001.fastq.gz
├── [1.6G]  21CG0020_S4_L003_R2_001.fastq.gz
├── [1.5G]  21CG0020_S4_L004_R1_001.fastq.gz
├── [1.5G]  21CG0020_S4_L004_R2_001.fastq.gz
├── [8.0G]  21CG0043_S1_R1_001.fastq.gz
├── [8.1G]  21CG0043_S1_R2_001.fastq.gz
├── [7.3G]  21CG0045_S2_R1_001.fastq.gz
├── [7.4G]  21CG0045_S2_R2_001.fastq.gz
├── [7.1G]  21CG0046_S3_R1_001.fastq.gz
├── [7.2G]  21CG0046_S3_R2_001.fastq.gz
├── [7.5G]  21CG0048_S4_R1_001.fastq.gz
├── [7.6G]  21CG0048_S4_R2_001.fastq.gz
├── [2.1G]  22CG001_S5_R1_001.fastq.gz
├── [2.1G]  22CG001_S5_R2_001.fastq.gz
├── [5.4G]  22CG002_S6_R1_001.fastq.gz
├── [5.5G]  22CG002_S6_R2_001.fastq.gz
├── [7.4G]  22CG003_S7_R1_001.fastq.gz
├── [7.5G]  22CG003_S7_R2_001.fastq.gz
├── [3.6G]  22CG004_S8_R1_001.fastq.gz
├── [3.7G]  22CG004_S8_R2_001.fastq.gz
├── [4.0G]  22CG005_S1_R1_001.fastq.gz
├── [4.0G]  22CG005_S1_R2_001.fastq.gz
├── [4.3G]  22CG006_S2_R1_001.fastq.gz
├── [4.4G]  22CG006_S2_R2_001.fastq.gz
├── [5.9G]  22CG007_S3_R1_001.fastq.gz
├── [5.9G]  22CG007_S3_R2_001.fastq.gz
├── [6.1G]  22CG008_S4_R1_001.fastq.gz
├── [6.2G]  22CG008_S4_R2_001.fastq.gz
├── [5.6G]  22CG009_S5_R1_001.fastq.gz
├── [5.7G]  22CG009_S5_R2_001.fastq.gz
├── [7.6G]  22CG010_S6_R1_001.fastq.gz
├── [7.7G]  22CG010_S6_R2_001.fastq.gz
├── [7.0G]  22CG011_S7_R1_001.fastq.gz
├── [7.0G]  22CG011_S7_R2_001.fastq.gz
├── [6.2G]  22CG012_S8_R1_001.fastq.gz
├── [6.3G]  22CG012_S8_R2_001.fastq.gz
├── [5.7G]  22CG013_S1_R1_001.fastq.gz
├── [5.8G]  22CG013_S1_R2_001.fastq.gz
├── [5.3G]  22CG014_S2_R1_001.fastq.gz
├── [5.3G]  22CG014_S2_R2_001.fastq.gz
├── [5.6G]  22CG015_S3_R1_001.fastq.gz
├── [5.7G]  22CG015_S3_R2_001.fastq.gz
├── [6.1G]  22CG016_S4_R1_001.fastq.gz
├── [6.3G]  22CG016_S4_R2_001.fastq.gz
├── [7.1G]  22CG017_S5_R1_001.fastq.gz
├── [7.1G]  22CG017_S5_R2_001.fastq.gz
├── [5.6G]  22CG018_S6_R1_001.fastq.gz
├── [5.6G]  22CG018_S6_R2_001.fastq.gz
├── [5.8G]  22CG019_S7_R1_001.fastq.gz
├── [5.8G]  22CG019_S7_R2_001.fastq.gz
├── [6.1G]  22CG020_S8_R1_001.fastq.gz
├── [6.2G]  22CG020_S8_R2_001.fastq.gz
├── [6.8G]  22CG021_S1_R1_001.fastq.gz
├── [6.9G]  22CG021_S1_R2_001.fastq.gz
├── [6.6G]  22CG022_S2_R1_001.fastq.gz
├── [6.7G]  22CG022_S2_R2_001.fastq.gz
├── [6.2G]  22CG023_S3_R1_001.fastq.gz
├── [6.2G]  22CG023_S3_R2_001.fastq.gz
├── [8.0G]  22CG024_S4_R1_001.fastq.gz
├── [8.1G]  22CG024_S4_R2_001.fastq.gz
├── [7.1G]  22CG025_S5_R1_001.fastq.gz
├── [7.2G]  22CG025_S5_R2_001.fastq.gz
├── [7.3G]  22CG026_S6_R1_001.fastq.gz
├── [7.3G]  22CG026_S6_R2_001.fastq.gz
├── [6.7G]  22CG027_S7_R1_001.fastq.gz
├── [6.8G]  22CG027_S7_R2_001.fastq.gz
├── [4.7G]  204DIY_FKA9361_S1_R1_001.fastq.gz
├── [4.8G]  204DIY_FKA9361_S1_R2_001.fastq.gz
├── [5.2G]  CUN8298_S2_R1_001.fastq.gz
├── [5.3G]  CUN8298_S2_R2_001.fastq.gz
├── [5.4G]  DVD4127_S3_R1_001.fastq.gz
├── [5.4G]  DVD4127_S3_R2_001.fastq.gz
├── [5.8G]  HP018_S8_R1_001.fastq.gz
├── [5.8G]  HP018_S8_R2_001.fastq.gz
├── [4.8G]  HP019_S1_R1_001.fastq.gz
├── [4.8G]  HP019_S1_R2_001.fastq.gz
├── [4.8G]  HP020_S2_R1_001.fastq.gz
├── [4.8G]  HP020_S2_R2_001.fastq.gz
├── [2.8G]  HP024_S3_R1_001.fastq.gz
├── [2.8G]  HP024_S3_R2_001.fastq.gz
├── [4.1G]  HP029_S4_R1_001.fastq.gz
├── [4.0G]  HP029_S4_R2_001.fastq.gz
├── [5.1G]  MKV7020_S6_R1_001.fastq.gz
├── [5.1G]  MKV7020_S6_R2_001.fastq.gz
├── [4.8G]  MTN2262_S7_R1_001.fastq.gz
├── [4.8G]  MTN2262_S7_R2_001.fastq.gz
├── [5.3G]  SP_19461001_S5_R1_001.fastq.gz
├── [5.3G]  SP_19461001_S5_R2_001.fastq.gz
├── [5.4G]  VMV3286_S4_R1_001.fastq.gz
└── [5.4G]  VMV3286_S4_R2_001.fastq.gz

 686G used in 0 directories, 246 files
```

</details>
<br/>
