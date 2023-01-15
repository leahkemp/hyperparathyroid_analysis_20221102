# 05 - Extract variants

Created: 2022/11/07 12:12:45
Last modified: 2023/01/16 10:42:16

- **Aim:** This document documents/describes extracting various variants of interest
- **Prerequisite software:** [GNU coreutils](https://www.gnu.org/software/coreutils/), [singularity](https://docs.sylabs.io/guides/3.5/user-guide/index.html) v3.7.2-1.el7, [slurm](https://slurm.schedmd.com/overview.html) v20.11.6
- **OS:** ORAC (CentOS Linux) (ESR production network)

## Table of contents

- [05 - Extract variants](#05---extract-variants)
  - [Table of contents](#table-of-contents)
  - [Extract variants of interest](#extract-variants-of-interest)
    - [Singleton](#singleton)
    - [Cohort](#cohort)

## Extract variants of interest

### Singleton

Run bash script to run do a quick and dirty grep for variants in a list of genes that the clinician recognizes are/possibly relevant to hyperparathyroidism. This is done on a priority sample (HP0041/22CG019), on the manually annotated vcf file (singleton analysis). See my script at [./scripts/05_extract_variants/01_quick_dirty_grep_genes_of_interest_singleton.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/01_quick_dirty_grep_genes_of_interest_singleton.sh)

```bash
sbatch ./scripts/05_extract_variants/01_quick_dirty_grep_genes_of_interest_singleton.sh
```

Also do a more robust extraction of variants in the list of genes using a bed file to subset the vcf file with. See my script at [./scripts/05_extract_variants/02_bed_extract_genes_of_interest_singleton.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/02_bed_extract_genes_of_interest_singleton.sh)

```bash
sbatch ./scripts/05_extract_variants/02_bed_extract_genes_of_interest_singleton.sh
```

Extract variants with a high CADD score. See my script at [./scripts/05_extract_variants/03_extract_high_cadd_singleton.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/03_extract_high_cadd_singleton.sh)

```bash
sbatch ./scripts/05_extract_variants/03_extract_high_cadd_singleton.sh
```

Extract variants with a high rankscore. See my script at [./scripts/05_extract_variants/04_extract_high_rankscore_singleton.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/04_extract_high_rankscore_singleton.sh)

```bash
sbatch ./scripts/05_extract_variants/04_extract_high_rankscore_singleton.sh
```

Extract variants in the list of genes with a high rankscore. See my script at [./scripts/05_extract_variants/05_extract_genes_of_interest_high_cadd_singleton.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/05_extract_genes_of_interest_high_cadd_singleton.sh)

```bash
sbatch ./scripts/05_extract_variants/05_extract_genes_of_interest_high_cadd_singleton.sh
```

Extract variants in the list of genes with a high CADD score. See my script at [./scripts/05_extract_variants/06_extract_genes_of_interest_high_rankscore_singleton.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/06_extract_genes_of_interest_high_rankscore_singleton.sh)

```bash
sbatch ./scripts/05_extract_variants/06_extract_genes_of_interest_high_rankscore_singleton.sh
```

Extract variants we're particularly interested in. See my script at [./scripts/05_extract_variants/07_extract_variants_of_interest_singleton.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/07_extract_variants_of_interest_singleton.sh)

```bash
sbatch ./scripts/05_extract_variants/07_extract_variants_of_interest_singleton.sh
```

Extract variants in several lists of variants from [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/). See my script at [./scripts/05_extract_variants/08_extract_variants_clinvar_singleton.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/08_extract_variants_clinvar_singleton.sh)

```bash
sbatch ./scripts/05_extract_variants/08_extract_variants_clinvar_singleton.sh
```

### Cohort

Run bash script to run do a quick and dirty grep for variants in a list of genes that the clinician recognizes are/possibly relevant to hyperparathyroidism. See my script at [./scripts/05_extract_variants/09_quick_dirty_grep_genes_of_interest_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/09_quick_dirty_grep_genes_of_interest_cohort.sh)

```bash
sbatch ./scripts/05_extract_variants/09_quick_dirty_grep_genes_of_interest_cohort.sh
```

Also do a more robust extraction of variants in the list of genes using a bed file to subset the vcf file with. See my script at [./scripts/05_extract_variants/10_bed_extract_genes_of_interest_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/10_bed_extract_genes_of_interest_cohort.sh)

```bash
sbatch ./scripts/05_extract_variants/10_bed_extract_genes_of_interest_cohort.sh
```

Extract variants with a high CADD score. See my script at [./scripts/05_extract_variants/11_extract_high_cadd_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/11_extract_high_cadd_cohort.sh)

```bash
sbatch ./scripts/05_extract_variants/11_extract_high_cadd_cohort.sh
```

Extract variants with a high rankscore. See my script at [./scripts/05_extract_variants/12_extract_high_rankscore_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/12_extract_high_rankscore_cohort.sh)

```bash
sbatch ./scripts/05_extract_variants/12_extract_high_rankscore_cohort.sh
```

Extract variants in the list of genes with a high rankscore. See my script at [./scripts/05_extract_variants/13_extract_genes_of_interest_high_cadd_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/13_extract_genes_of_interest_high_cadd_cohort.sh)

```bash
sbatch ./scripts/05_extract_variants/13_extract_genes_of_interest_high_cadd_cohort.sh
```

Extract variants in the list of genes with a high CADD score. See my script at [./scripts/05_extract_variants/14_extract_genes_of_interest_high_rankscore_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/14_extract_genes_of_interest_high_rankscore_cohort.sh)

```bash
sbatch ./scripts/05_extract_variants/14_extract_genes_of_interest_high_rankscore_cohort.sh
```

Extract variants we're particularly interested in. See my script at [./scripts/05_extract_variants/15_extract_variants_of_interest_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/15_extract_variants_of_interest_cohort.sh)

```bash
sbatch ./scripts/05_extract_variants/15_extract_variants_of_interest_cohort.sh
```

Extract variants in several lists of variants from [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/). See my script at [./scripts/05_extract_variants/16_extract_variants_clinvar_cohort.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/16_extract_variants_clinvar_cohort.sh)

*Note. the clinvar lists used in these scripts (and found in `./config/05_extract_variants/`) were manually downloaded from [clinvar](https://www.ncbi.nlm.nih.gov/clinvar/) (creating the .txt files). These were then converted to bed files using the `./scripts/general/convert_clinvar_list_to_bed.R` script*

```bash
sbatch ./scripts/05_extract_variants/16_extract_variants_clinvar_cohort.sh
```

Extract variants that are present in all or most of the patients. See my script at [./scripts/05_extract_variants/17_extract_variants_cohort_frequency.sh](https://github.com/ESR-NZ/hyperparathyroid_analysis_20221102/blob/main/scripts/05_extract_variants/17_extract_variants_cohort_frequency.sh)

```bash
sbatch ./scripts/05_extract_variants/17_extract_variants_cohort_frequency.sh
```
