#!/bin/bash

# ==============================
# Set the quoting prefix for logging
# ==============================
QUOTE="$0: $(hostname):"

# ==============================
# Determine output directory
# ==============================
if [ -n "${SCR+x}" ]; then
    BASE_DIR="${SCR}"
else
	BASE_DIR="$(pwd)/agfhc_logs"
fi

# Ensure parent directory exists
mkdir -p "${BASE_DIR}"

# ==============================
# Create unique per-node log directory with timestamp
# ==============================
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
NODE=$(hostname)
OUTDIR="${BASE_DIR}/agfhc_${NODE}_${TIMESTAMP}"

# ==============================
# Run AGFHC
# ==============================
echo "${QUOTE} Running AGFHC, output dir: ${OUTDIR}"
#/opt/amd/agfhc/agfhc -r single_pass -o "${OUTDIR}"


source /u/bhukumar/tool/node-scraper/venv/bin/activate

pip install --upgrade pip
pip install psutil
#pip install PyYAML


export TXB_PATH=/u/bhukumar/tool/install/transferbench
export FIREXS_PATH=/u/bhukumar/tool/install/firexs2
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$FIREXS_PATH/usr/lib
export FIREXS2_APP_PATH=$FIREXS_PATH/usr/lib/firexs2
export MINIHPL_PATH=/u/bhukumar/tool/install/minihpl
export ROCHPL_PATH=/ptmp/$USER/AGFHC/rochpl_bin

/u/bhukumar/tool/install/agfhc/agfhc  -r single_pass -o "${OUTDIR}"
