
if config["hicstuff"]["matfmt"] =="bg2":
	out_format_hicstuff_file=".bg2"
elif config["hicstuff"]["matfmt"] == "cool":
	out_format_hicstuff_file=".cool"
else:
	config["hicstuff"]["matfmt"] == "graal"
	out_format_hicstuff_file = ".tsv"

digestion=",".join(config["hicstuff"]["digestion"])

if config["hicstuff"]["rm_duplicates"]:
	out_format_hicstuff_pairs=".valid_idx_pcrfree.pairs"
	config["hicstuff"]["supp"]=config["hicstuff"]["supp"]+" --duplicates"
else:
	out_format_hicstuff_pairs=".valid_idx.pairs"

rule hicstuff_pipeline:
	input:
		ref=GENOME,
		fastq1=IN+"{prefix}"+R1+".trimmed"+EXT,
		fastq2=IN+"{prefix}"+R2+".trimmed"+EXT
	output:
		outfile=OUT+"out_{prefix}_{aligner}/{prefix}_hicstuff_{mapping}"+out_format_hicstuff_file,
		outpair=OUT+"out_{prefix}_{aligner}/tmp/{prefix}_hicstuff_{mapping}"+out_format_hicstuff_pairs
	params:
		outdir=OUT+"out_{prefix}_{aligner}",
		mapping="{mapping}",
		aligner="{aligner}",
		prefix_hicstuff = "{prefix}_hicstuff_{mapping}",
		matfmt=config["hicstuff"]["matfmt"],
		digestion=digestion,
		supp=config["hicstuff"]["supp"]
	log:
		OUT+"logs/hicstuff_pipeline/{prefix}_hicstuff_{aligner}_{mapping}.log"
	benchmark:
		OUT+"benchmark/hicstuff_pipeline/{prefix}_hicstuff_{aligner}_{mapping}.txt"
	threads:config["general"]["threads"]["aln"]
	conda: "../envs/hicstuff.yaml"
	shell:
		"hicstuff pipeline -t {threads} "
		"-a {params.aligner} -e {params.digestion} "
		"-g {input.ref} --mapping={params.mapping} "
		"-o {params.outdir} --prefix {params.prefix_hicstuff} "
		"{params.supp} "
		"--matfmt {params.matfmt} "
		"{input.fastq1} {input.fastq2} > {log}"
