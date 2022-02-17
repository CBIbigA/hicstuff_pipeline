
rule makeChromSize:
	input:
		fasta=GENOME
	output:
		chromsize=OUT+config["genome"]["name"]+"chrom.size",
		fai=GENOME+".fai"
	params:
		genome=config["genome"]["name"]
	log:
		OUT+"logs/makeChromSize/{params.genome}.log"
	benchmark:
		OUT+"benchmark/makeChromSize/{params.genome}.txt"
	conda: "../envs/samtools.yaml"
	shell:
		"samtools faidx {input.fasta} -o {output.fai} && cut -f1,2 {output.fai} > {output.chromsize}"