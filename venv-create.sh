#!/usr/bin/env bash
#https://scicomp.ethz.ch/wiki/Conda
echo Loading modules
module load stack/2024-06 python/3.11.6 eth_proxy
echo Creating new venv under `pwd`/.venv
# Skip `--system-site-packages` as it currently fails
python -m venv .venv
echo Activating new venv
source .venv/bin/activate
echo Installing packages
pip install pandas snakemake==8.16.0 snakemake-executor-plugin-cluster-generic snakemake-storage-plugin-fs
#https://stackoverflow.com/questions/12079607/make-virtualenv-inherit-specific-packages-from-your-global-site-packages
#pip install -U pandas snakemake==8.16.0 snakemake-executor-plugin-cluster-generic snakemake-storage-plugin-fs
