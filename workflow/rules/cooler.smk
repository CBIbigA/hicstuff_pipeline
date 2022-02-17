rule cooler_pairs:
	input:
		pairfile=OUT+"out_{prefix}_{aligner}/tmp/{prefix}_hicstuff_{mapping}.sorted.pairs",
		chromsize=OUT+config["genome"]["name"]+".chrom.size"
	output:
		OUT+"out_{prefix}_{aligner}/{prefix}_hicstuff_{mapping}.cool"
	log:
		OUT+"logs/cooler_pairs/{prefix}_{aligner}_{mapping}.log"
	benchmark:
		OUT+"benchmark/cooler_pairs/{prefix}_{aligner}_{mapping}.txt"
	conda: "../envs/cooler.yaml"
	params:
		minres=config["cooler"]["minres"]
	shell:
		"cooler cload pairs -c1 2 -p1 3 -c2 4 -p2 5 {input.chromsize}:{params.minres} {input.pairfile} {output}"


rule cooler_zoomify:
	input:
		coolfile=OUT+"out_{prefix}_{aligner}/{prefix}_hicstuff_{mapping}.cool"
	output:
		OUT+"out_{prefix}_{aligner}/{prefix}_hicstuff_{mapping}.mcool"
	log:
		OUT+"logs/cooler_zoomify/{prefix}_{aligner}_{mapping}.log"
	benchmark:
		OUT+"benchmark/cooler_zoomify/{prefix}_{aligner}_{mapping}.txt"
	conda: "../envs/cooler.yaml"
	threads:config["general"]["threads"]["matrix"]
	params:
		resolutions=config["cooler"]["resolutions"],
		options=config["cooler"]["options"]
	shell:
		"cooler zoomify {params.options} -p {threads} -r {params.resolutions} {input}"



