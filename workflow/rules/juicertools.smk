
rule generate_site_positions:
	input:
		ref=GENOME
	output:
		OUT+config["genome"]["name"]+"_"+config["juicer"]["digestion"]+".txt"
	params:
		script=config["juicer"]["generate_site_positions"],
		digestion=config["juicer"]["digestion"],
		genome=config["genome"]["name"]
	log:
		f"{OUT}logs/generate_site_positions/{config["juicer"]["digestion"]}_{config["genome"]["name"]}.log"
	benchmark:
		f"{OUT}benchmark/generate_site_positions/{config["juicer"]["digestion"]}_{config["genome"]["name"]}.txt"
	conda: "../envs/pairtools.yaml"
	shell:
		"{params.script} {params.digestion} {params.genome} {input}"





rule juicer_pre:
	input:
		pairfile=OUT+"out_{prefix}_{aligner}/tmp/{prefix}_hicstuff_{mapping}.sorted.pairs",
		digestion_sites=OUT+config["genome"]["name"]+"_"+config["juicer"]["digestion"]+".txt",
		chromsize=OUT+config["genome"]["name"]+".chrom.size"
	output:
		OUT+"out_{prefix}_{aligner}/{prefix}_hicstuff_{mapping}.hic"
	log:
		OUT+"logs/juicer_pre/{prefix}_{aligner}_{mapping}.log"
	benchmark:
		OUT+"benchmark/juicer_pre/{prefix}_{aligner}_{mapping}.txt"
	conda: "../envs/java-jdk.yaml"
	threads:config["general"]["threads"]["matrix"]
	params:
		juicertools=config["juicer"]["juicertools"],
		resolutions=config["juicer"]["resolutions"]
	shell:
		"java -jar {params.juicertools} pre -f {input.digestion_sites} --threads {threads} -r {params.resolutions} {input.pairfile} {output} {input.chromsize}"
