# read raw clinvar tables
data_1 <- read.table("/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_hyperparathyroidism_pathogenic_multiple_submitters_snp.txt", header = TRUE, sep = "\t")
data_2 <- read.table("/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_hyperparathyroidism_likely_pathogenic_multiple_submitters_snp.txt", header = TRUE, sep = "\t")
data_3 <- read.table("/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_endocrine_pathogenic_multiple_submitters_snp.txt", header = TRUE, sep = "\t")
data_4 <- read.table("/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_hyperparathyroidism_pathogenic_snp.txt", header = TRUE, sep = "\t")
data_5 <- read.table("/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_hyperparathyroidism_likely_pathogenic_snp.txt", header = TRUE, sep = "\t")
data_6 <- read.table("/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_MEN1_pathogenic_multiple_submitters_snp.txt", header = TRUE, sep = "\t")
data_7 <- read.table("/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_genes_of_interest_pathogenic_multiple_submitters_snp.txt", header = TRUE, sep = "\t")
data_8 <- read.table("/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_genes_of_interest_likely_pathogenic_multiple_submitters_snp.txt", header = TRUE, sep = "\t")

# extract columns with chromosome location (for GRCh37 reference genome build)
bed_1 <- data.frame(data_1$GRCh37Chromosome, data_1$GRCh37Location)
bed_2 <- data.frame(data_2$GRCh37Chromosome, data_2$GRCh37Location)
bed_3 <- data.frame(data_3$GRCh37Chromosome, data_3$GRCh37Location)
bed_4 <- data.frame(data_4$GRCh37Chromosome, data_4$GRCh37Location)
bed_5 <- data.frame(data_5$GRCh37Chromosome, data_5$GRCh37Location)
bed_6 <- data.frame(data_6$GRCh37Chromosome, data_6$GRCh37Location)
bed_7 <- data.frame(data_7$GRCh37Chromosome, data_7$GRCh37Location)
bed_8 <- data.frame(data_8$GRCh37Chromosome, data_8$GRCh37Location)

# create end location columns
bed_1$data_1.GRCh37Location.end <- bed_1$data_1.GRCh37Location
bed_1$data_1.GRCh37Location <- sub("-.*", "", bed_1$data_1.GRCh37Location)
bed_1$data_1.GRCh37Location.end <- sub(".*-", "", bed_1$data_1.GRCh37Location.end)
bed_1$data_1.GRCh37Location.end <- sub(".* ", "", bed_1$data_1.GRCh37Location.end)

bed_2$data_2.GRCh37Location.end <- bed_2$data_2.GRCh37Location
bed_2$data_2.GRCh37Location <- sub("-.*", "", bed_2$data_2.GRCh37Location)
bed_2$data_2.GRCh37Location.end <- sub(".*-", "", bed_2$data_2.GRCh37Location.end)
bed_2$data_2.GRCh37Location.end <- sub(".* ", "", bed_2$data_2.GRCh37Location.end)

bed_3$data_3.GRCh37Location.end <- bed_3$data_3.GRCh37Location
bed_3$data_3.GRCh37Location <- sub("-.*", "", bed_3$data_3.GRCh37Location)
bed_3$data_3.GRCh37Location.end <- sub(".*-", "", bed_3$data_3.GRCh37Location.end)
bed_3$data_3.GRCh37Location.end <- sub(".* ", "", bed_3$data_3.GRCh37Location.end)

bed_4$data_4.GRCh37Location.end <- bed_4$data_4.GRCh37Location
bed_4$data_4.GRCh37Location <- sub("-.*", "", bed_4$data_4.GRCh37Location)
bed_4$data_4.GRCh37Location.end <- sub(".*-", "", bed_4$data_4.GRCh37Location.end)
bed_4$data_4.GRCh37Location.end <- sub(".* ", "", bed_4$data_4.GRCh37Location.end)

bed_5$data_5.GRCh37Location.end <- bed_5$data_5.GRCh37Location
bed_5$data_5.GRCh37Location <- sub("-.*", "", bed_5$data_5.GRCh37Location)
bed_5$data_5.GRCh37Location.end <- sub(".*-", "", bed_5$data_5.GRCh37Location.end)
bed_5$data_5.GRCh37Location.end <- sub(".* ", "", bed_5$data_5.GRCh37Location.end)

bed_6$data_6.GRCh37Location.end <- bed_6$data_6.GRCh37Location
bed_6$data_6.GRCh37Location <- sub("-.*", "", bed_6$data_6.GRCh37Location)
bed_6$data_6.GRCh37Location.end <- sub(".*-", "", bed_6$data_6.GRCh37Location.end)
bed_6$data_6.GRCh37Location.end <- sub(".* ", "", bed_6$data_6.GRCh37Location.end)

bed_7$data_7.GRCh37Location.end <- bed_7$data_7.GRCh37Location
bed_7$data_7.GRCh37Location <- sub("-.*", "", bed_7$data_7.GRCh37Location)
bed_7$data_7.GRCh37Location.end <- sub(".*-", "", bed_7$data_7.GRCh37Location.end)
bed_7$data_7.GRCh37Location.end <- sub(".* ", "", bed_7$data_7.GRCh37Location.end)

bed_8$data_8.GRCh37Location.end <- bed_8$data_8.GRCh37Location
bed_8$data_8.GRCh37Location <- sub("-.*", "", bed_8$data_8.GRCh37Location)
bed_8$data_8.GRCh37Location.end <- sub(".*-", "", bed_8$data_8.GRCh37Location.end)
bed_8$data_8.GRCh37Location.end <- sub(".* ", "", bed_8$data_8.GRCh37Location.end)

# write to file - creating a bed file
write.table(bed_1,
            "/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_hyperparathyroidism_pathogenic_multiple_submitters_snp.bed",
            sep = "\t",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)

write.table(bed_2,
            "/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_hyperparathyroidism_likely_pathogenic_multiple_submitters_snp.bed",
            sep = "\t",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)

write.table(bed_3,
            "/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_endocrine_pathogenic_multiple_submitters_snp.bed",
            sep = "\t",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)

write.table(bed_4,
            "/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_hyperparathyroidism_pathogenic_snp.bed",
            sep = "\t",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)

write.table(bed_5,
            "/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_hyperparathyroidism_likely_pathogenic_snp.bed",
            sep = "\t",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)

write.table(bed_6,
            "/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_MEN1_pathogenic_multiple_submitters_snp.bed",
            sep = "\t",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)

write.table(bed_7,
            "/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_genes_of_interest_pathogenic_multiple_submitters_snp.bed",
            sep = "\t",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)

write.table(bed_8,
            "/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102/config/05_extract_variants/clinvar_genes_of_interest_likely_pathogenic_multiple_submitters_snp.bed",
            sep = "\t",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE)
