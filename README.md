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

There’s also `slurm_extra` to add additional arguments (e.g. [allocate a GPU](https://scicomp.ethz.ch/wiki/Getting_started_with_GPUs#How_to_select_GPU_memory) with `--gpus:1`) to the `sbatch` call. However, there seems to be bug with colon characters in resource definitions, similar to [what has been described previously](https://github.com/snakemake/snakemake/issues/2701). As a workaround, `slurm_extra` is "percentage-decoded" for colons (`%3A` changed to `:`) using `sed` such that, after additional quoting, GPU resources can be specified as follows:
```
set-resources:
    # ...
    run_multimer:
        # ...  
        slurm_extra: "'--gpus=rtx_4090%3A2 --gres=gpumem%3A24g'"
```
This will allocate two rtx_4090 GPUs with 24g memory (`--gpus=rtx_4090:2 --gres=gpumem:24g`)
