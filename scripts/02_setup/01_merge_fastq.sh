#!/bin/bash

#SBATCH --partition rocky8
#SBATCH --time=01:00:00
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --job-name="01_merge_fastq"
#SBATCH --output="./logs/02_setup/slurm-%j-%x.out"

# configure file paths
project_dir="/NGS/humangenomics/active/2022/run/hyperparathyroid_analysis_20221102"

# rename some files for the sake of consistant naming conventions
echo ""
echo "Renaming fastq files"
echo ""

mv $project_dir/fastq/204DIY_FKA9361_S1_R1_001.fastq.gz $project_dir/fastq/21CG0021_S1_R1.fastq.gz
mv $project_dir/fastq/204DIY_FKA9361_S1_R2_001.fastq.gz $project_dir/fastq/21CG0021_S1_R2.fastq.gz

mv $project_dir/fastq/CUN8298_S2_R1_001.fastq.gz $project_dir/fastq/21CG0034_S2_R1.fastq.gz
mv $project_dir/fastq/CUN8298_S2_R2_001.fastq.gz $project_dir/fastq/21CG0034_S2_R2.fastq.gz

mv $project_dir/fastq/DVD4127_S3_R1_001.fastq.gz $project_dir/fastq/21CG0035_S3_R1.fastq.gz
mv $project_dir/fastq/DVD4127_S3_R2_001.fastq.gz $project_dir/fastq/21CG0035_S3_R2.fastq.gz

mv $project_dir/fastq/VMV3286_S4_R1_001.fastq.gz $project_dir/fastq/21CG0036_S4_R1.fastq.gz
mv $project_dir/fastq/VMV3286_S4_R2_001.fastq.gz $project_dir/fastq/21CG0036_S4_R2.fastq.gz

mv $project_dir/fastq/SP_19461001_S5_R1_001.fastq.gz $project_dir/fastq/21CG0037_S5_R1.fastq.gz
mv $project_dir/fastq/SP_19461001_S5_R2_001.fastq.gz $project_dir/fastq/21CG0037_S5_R2.fastq.gz

mv $project_dir/fastq/MKV7020_S6_R1_001.fastq.gz $project_dir/fastq/21CG0038_S6_R1.fastq.gz
mv $project_dir/fastq/MKV7020_S6_R2_001.fastq.gz $project_dir/fastq/21CG0038_S6_R2.fastq.gz

mv $project_dir/fastq/MTN2262_S7_R1_001.fastq.gz $project_dir/fastq/21CG0039_S7_R1.fastq.gz
mv $project_dir/fastq/MTN2262_S7_R2_001.fastq.gz $project_dir/fastq/21CG0039_S7_R2.fastq.gz

mv $project_dir/fastq/HP018_S8_R1_001.fastq.gz $project_dir/fastq/21CG0040_S8_R1.fastq.gz
mv $project_dir/fastq/HP018_S8_R2_001.fastq.gz $project_dir/fastq/21CG0040_S8_R2.fastq.gz

mv $project_dir/fastq/HP019_S1_R1_001.fastq.gz $project_dir/fastq/21CG0041_S1_R1.fastq.gz
mv $project_dir/fastq/HP019_S1_R2_001.fastq.gz $project_dir/fastq/21CG0041_S1_R2.fastq.gz

mv $project_dir/fastq/HP020_S2_R1_001.fastq.gz $project_dir/fastq/21CG0042_S2_R1.fastq.gz
mv $project_dir/fastq/HP020_S2_R2_001.fastq.gz $project_dir/fastq/21CG0042_S2_R2.fastq.gz

mv $project_dir/fastq/HP024_S3_R1_001.fastq.gz $project_dir/fastq/21CG0044_S3_R1.fastq.gz
mv $project_dir/fastq/HP024_S3_R2_001.fastq.gz $project_dir/fastq/21CG0044_S3_R2.fastq.gz

mv $project_dir/fastq/HP029_S4_R1_001.fastq.gz $project_dir/fastq/21CG0047_S4_R1.fastq.gz
mv $project_dir/fastq/HP029_S4_R2_001.fastq.gz $project_dir/fastq/21CG0047_S4_R2.fastq.gz

# strip "S1" (or equivilant) and "_001" from filenames before merge so there is only sample, lane and read info in the filenames
for file in $project_dir/fastq/*.fastq.gz ; do mv "$file" "$(echo "$file" | sed -r 's/_001//')" ; done
for file in $project_dir/fastq/*.fastq.gz ; do mv "$file" "$(echo "$file" | sed -r 's/_S[0-9]{1}//')" ; done

# also convert R1/R2 in file names to 1/2 (requirement for pipeline)
for file in $project_dir/fastq/*.fastq.gz ; do mv "$file" "$(echo "$file" | sed -r 's/R//')" ; done

# merge files (that aren't already lane merged)
echo ""
echo "Merge fastq files"
echo ""

for sample in $(find $project_dir/fastq/*_L00* -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 17- | rev; done | sort | uniq); do

    echo ""
    echo "Merging R1 for sample:"
    echo $sample
    echo ""
    
    cat "$project_dir/fastq/$sample"_L00*_1.fastq.gz > $project_dir/fastq/"$sample"_1.fastq.gz

    echo ""
    echo "Merging R2 for sample:"
    echo $sample
    echo ""
    
    cat "$project_dir/fastq/$sample"_L00*_2.fastq.gz > $project_dir/fastq/"$sample"_2.fastq.gz

done;

# cleanup unmerged fastq files
echo ""
echo "Cleaning up unmerged fastq files"
echo ""

rm $project_dir/fastq/*_L00*
