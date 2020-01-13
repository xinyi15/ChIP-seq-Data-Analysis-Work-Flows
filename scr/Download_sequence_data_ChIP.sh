#!/bin/bash

#SBATCH --job-name=run_5981
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --time=168:00:00
#SBATCH --ntasks=1
#SBATCH --mem=500g
#SBATCH --mail-type=END   
#SBATCH --mail-user=<Email Address>@email.unc.edu 


module load sratoolkit/2.9.6

for run in <Run Accessions> #SRR5385295 SRR5385296 SRR5385263
do
        fastq-dump $run 
done

