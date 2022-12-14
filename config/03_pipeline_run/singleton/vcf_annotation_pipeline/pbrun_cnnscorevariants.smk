rule pbrun_cnnscorevariants:
    input:
        vcf = "../../human_genomics_pipeline/results/called/{sample}_raw_snps_indels.vcf",
        bams = "../../human_genomics_pipeline/results/mapped/{sample}_recalibrated.bam",
        refgenome = expand("{refgenome}", refgenome = config['REFGENOME'])
    output:
        temp("../results/filtered/{sample}_scored.vcf")
    resources:
        gpu = config['GPU']
    log:
        "logs/pbrun_cnnscorevariants/{sample}.log"
    benchmark:
        "benchmarks/pbrun_cnnscorevariants/{sample}.tsv"
    message:
        "Annotating {input.vcf} with scores from a Convolutional Neural Network (CNN) (2D model with pre-trained architecture)"
    shell:
        "/opt/parabricks/3.6.1/parabricks/pbrun cnnscorevariants --in-vcf {input.vcf} --in-bam {input.bams} --ref {input.refgenome} --out-vcf {output} --num-gpus {resources.gpu} &> {log}"