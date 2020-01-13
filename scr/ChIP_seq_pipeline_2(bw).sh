#!/bin/bash

#SBATCH --job-name=run_chip
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --time=168:00:00
#SBATCH --ntasks=1
#SBATCH --mem=200g
#SBATCH --mail-type=END   
#SBATCH --mail-user=<Email Address>@email.unc.edu 

module load bowtie2
module load samtools
module load deeptools

for f in <Run Accessions> #SRR5385276 SRR5385277 SRR5385278 SRR5385279 SRR5385280 SRR5385281 SRR5385282 SRR5385283 SRR5385284 SRR5385285 SRR5385286 SRR5385287 SRR5385288 SRR5385289 SRR5385290 SRR5385291 SRR5385292 SRR5385293 SRR5385294 SRR5385295 SRR5385296 SRR5385297 SRR5385263 
do

bamCoverage -b /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam.bam.sorted.bam.nodup.bam \
-o /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/BW/${f}.bw \
--binSize 20 \
--normalizeUsing BPM \
--smoothLength 60 \
--extendReads 150 \
--centerReads \
-p 6 2> /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/BW/${f}.log

done
