# Simple Slurm (for euler)
A fork of the
[Simple Slurm](https://github.com/jdblischak/smk-simple-slurm)
[snakemake profile](https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles)
for Euler, used in
[batch-infer](https://github.com/jurgjn/batch-infer):
```
cd $HOME/.config/snakemake
git clone git@github.com:jurgjn/smk-simple-slurm-eu.git
snakemake --profile smk-simple-slurm-eu ...
```

Snakemake [standard resources](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#standard-resources)
are mapped to [Euler sbatch equivalents](https://scicomp.ethz.ch/wiki/Using_the_batch_system#Resource_requirements)
as follows:
| snakemake  | description          | euler/sbatch    | comment |
| ---------- |----------------------|-----------------|---------|
| `runtime`  | wall-clock time      | `--time`        | converted, e.g. `1d` becomes `'1-00:00:00'` |
| `threads`  | number of cores      | `--ntasks`      | |
| `mem_mb`   | total RAM            | `--mem-per-cpu` | converted to ram-per-CPU based using the number of cores |
| `disk_mb`  | [local scratch](https://scicomp.ethz.ch/wiki/Using_local_scratch)  | `--tmp`         | |

There’s also `slurm_extra` for additional arguments to `sbatch`:
- [allocate a GPU](https://scicomp.ethz.ch/wiki/Getting_started_with_GPUs#How_to_select_GPU_memory), e.g. `--gpus=rtx_2080_ti:1`
- [specify a shareholder group](https://docs.hpc.ethz.ch/batchsystem/slurm/?h=my_share_inf#my_share_info), e.g. `--account=es_example`

## Known issues & workarounds
- Job status checks with `sacct` sometimes return empty output (with the job running); as a workaround, `status-sacct.sh` will specifically check for this and return `running`
- Cancelling jobs is unreliable for unknown reasons
