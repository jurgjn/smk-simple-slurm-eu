A fork of [jdblischak/smk-simple-slurm](https://github.com/jdblischak/smk-simple-slurm) for the Euler cluster:
```
cd $HOME/.config/snakemake
git clone git@github.com:jurgjn/smk-simple-slurm-eu.git
snakemake --profile smk-simple-slurm-eu ...
```

Snakemake [standard resources](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#standard-resources)
are mapped to [Euler equivalents](https://scicomp.ethz.ch/wiki/Using_the_batch_system#Resource_requirements)
as follows:
- `threads` sets number of cores; mapped to `--ntasks`
- `mem_mb` sets total RAM; mapped to `--mem-per-cpu` by accounting for cores: `expr {resources.mem_mb} / {threads}`
- `disk_mb` sets Euler's [local scratch space](https://scicomp.ethz.ch/wiki/Using_local_scratch); mapped to `--tmp`
- `runtime` sets max wall-clock time; mapped to `--time` and converted for `sbatch` if needed, e.g. `1d` becomes `'1-00:00:00'`

There’s also `slurm_extra` for additional arguments to `sbatch`:
- [allocate a GPU](https://scicomp.ethz.ch/wiki/Getting_started_with_GPUs#How_to_select_GPU_memory), e.g. `--gpus=rtx_2080_ti:1`
- [specify a shareholder group](https://docs.hpc.ethz.ch/batchsystem/slurm/?h=my_share_inf#my_share_info), e.g. `--account=es_example`

## Known issues & workarounds
- Job status checks with `sacct` sometimes return empty output (with the job running); as a workaround, `status-sacct.sh` will specifically check for this and return `running`
- Cancelling jobs is unreliable for unknown reasons
