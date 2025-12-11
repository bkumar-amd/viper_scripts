#!/bin/bash

QUOTE="$0: $(hostname):"

# Determine base log directory
if [ -n "${SCR+x}" ]; then
    BASE_DIR="${SCR}/node-scraper"
else
	BASE_DIR="$(pwd)/node-scraper_logs"
fi

mkdir -p "${BASE_DIR}"

# Unique per-node log dir: node + job ID + timestamp
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
NODE=$(hostname)
OUTDIR="${BASE_DIR}/scraper_${NODE}_${SLURM_JOB_ID}_${TIMESTAMP}"
mkdir -p "${OUTDIR}"

echo "${QUOTE} Running node-scraper, output dir: ${OUTDIR}"
source /u/bhukumar/tool/node-scraper/venv/bin/activate

node-scraper --log-path="${OUTDIR}" \
      	run-plugins BiosPlugin CmdlinePlugin RocmPlugin \
	UptimePlugin ProcessPlugin MemoryPlugin OsPlugin \
	PackagePlugin KernelPlugin KernelModulePlugin DkmsPlugin

