# Snakemake workflow: `hicstuff_pipeline`

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/CBIbigA/hicstuff_pipeline/workflows/Tests/badge.svg?branch=main)](https://github.com/CBIbigA/hicstuff_pipeline/actions?query=branch%3Amain+workflow%3ATests)


A Snakemake workflow for Hi-c reads alignments with hicstuff


## Usage

The usage of this workflow is described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=CBIbigA%2Fhicstuff_pipeline).

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) hicstuff_pipelinesitory and its DOI (see above).

# TODO

- Deploy the pipeline: `snakedeploy deploy-workflow https://github.com/CBIbigA/hicstuff_pipeline hicstuff_pipeline --branch main --force`
- Create the scripts directory: `cd hicstuff_pipeline && mkdir scripts && cd scripts`
- Get the files:
  - `wget https://github.com/CBIbigA/hicstuff_pipeline/raw/main/workflow/scripts/generate_site_positions.py`
  - `wget https://github.com/CBIbigA/hicstuff_pipeline/raw/main/workflow/scripts/juicer_tools_1.22.01.jar`
- Make sure you can execute the script: `chmod +x generate_site_positions.py`
- Go into `hicstuff_pipeline` and launch `snakemake --use-conda`
