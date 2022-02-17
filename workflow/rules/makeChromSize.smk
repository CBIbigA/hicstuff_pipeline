
rule makeChromSize:
	input:
		fasta=GENOME
	output:
		chromsize=OUT+config["genome"]["name"]+".chrom.size",
		fai=GENOME+".fai"
	params:
		genome=config["genome"]["name"]
	log:
		f"{OUT}logs/makeChromSize/{config['genome']['name']}.log"
	benchmark:
		f"{OUT}benchmark/makeChromSize/{config['genome']['name']}.txt"
	conda: "../envs/samtools.yaml"
	shell:
		"samtools faidx {input.fasta} -o {output.fai} && cut -f1,2 {output.fai} > {output.chromsize} 2> {log}"
