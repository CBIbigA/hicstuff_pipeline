wildcard_constraints:
	extension=config["raw_spec"]["pairs_expr"]



rule cutadapt:
	input:
		IN+"{prefix}{extension}"+EXT
	output:
		fastq=IN+"{prefix}{extension}.trimmed"+EXT,
		qc=IN+"{prefix}{extension}.trimmed.qc"
	log:
		OUT+"logs/cutadapt/{prefix}{extension}.log"
	benchmark:
		OUT+"benchmark/cutadapt/{prefix}{extension}.txt"
	threads:config["general"]["threads"]["trimming"]
	params:
		adapters = "",
		extra = "--cut 10"
	conda:
		"envs/cutadapt.yaml"
	shell:
		"cutadapt {params.adapters} {params.extra} -j {threads} -o {output.fastq} {input} > {output.qc} {log}"