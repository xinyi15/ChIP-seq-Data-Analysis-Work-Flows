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
module load macs

for f in <Run Accessions> #eg: SRR5385276 SRR5385277 SRR5385278 SRR5385279 SRR5385280 SRR5385281 SRR5385282 SRR5385283 SRR5385284 SRR5385285 SRR5385286 SRR5385287 SRR5385288 SRR5385289 SRR5385290 SRR5385291 SRR5385292 SRR5385293 SRR5385294 SRR5385295 SRR5385296 SRR5385297 SRR5385263 
do

bowtie2 -x /proj/seq/data/MM10_UCSC/Sequence/Bowtie2Index/genome -S /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam -U ${f}.fastq

samtools view -Sh /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam | grep -e "^@" -e "XM:i:[012][^0-9]" | grep -v "XS:i:" > /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam  

samtools view -S -b /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam > /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam.bam
samtools sort -T a5.sorted -o /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam.bam.sorted.bam /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam.bam

samtools rmdup -s /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam.bam.sorted.bam  /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam.bam.sorted.bam.nodup.bam

samtools index /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam.bam.sorted.bam.nodup.bam

macs2 callpeak -t /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}.sam.filtered.sam.bam.sorted.bam.nodup.bam -n /pine/scr/x/i/xinyi7/SRAdata/Emily_0103/Chip_seq_59-80-93/Result_1/${f}_macs2 -f BAM

done
