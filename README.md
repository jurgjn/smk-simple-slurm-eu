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
