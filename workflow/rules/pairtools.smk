rule pairtools_sort:
	input:
		pairs=OUT+"out_{prefix}_{aligner}/tmp/{prefix}_hicstuff_{mapping}"+out_format_hicstuff_pairs
	output:
		temp(OUT+"out_{prefix}_{aligner}/tmp/{prefix}_hicstuff_{mapping}.sorted.pairs")
	log:
		OUT+"logs/pairtools_sort/{prefix}_{aligner}_{mapping}.log"
	benchmark:
		OUT+"benchmark/pairtools_sort/{prefix}_{aligner}_{mapping}.txt"
	conda: "envs/pairtools.yaml"
	threads:config["general"]["threads"]["matrix"]
	shell:
		"pairtools sort --nproc {threads} {input} -o {output} > {log}"
