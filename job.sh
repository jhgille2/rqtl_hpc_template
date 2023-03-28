#!/bin/bash

# Submit the pipeline as a job with srun job.sh

# Modified from https://github.com/mschubert/clustermq/blob/master/inst/LSF.tmpl
# under the Apache 2.0 license:
#SBATCH --job-name=rqtl_template_test
#SBATCH --output=/dev/null
#SBATCH --error=/dev/null
#SBATCH --mem-per-cpu=3000
#SBATCH --cpus-per-task=1
#SBATCH -N 1
#SBATCH -n 5
#SBATCH -t 1:00:00
#SBATCH --mail-user=jhgille2@ncsu.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module load R # Comment out if R is not an environment module.
module load miniconda
source activate r_qtl_hpc
R CMD BATCH run.R

# Removing .RData is recommended.
# rm -f .RData
