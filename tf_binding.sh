# Exercise 1 Get NFKB binding sites only

grep -i 'NFKB' tfbed.txt > tf.nfkb.bed

#Exercise 2 Extract nly the genes from the GTF file

grep -i -w 'transcript' gencode.v19.annotation.chr22.gtf > gencode.v19.annotation.chr22.transcript.gtf

#Exercise 3 Use biotools flank to get the promoters
module load biotools
bedtools flank -i gencode.v19.annotation.chr22.transcript.gtf -g hg19.genome -s -l 2000 -r 0 > gencode.v19.annotation.chr22.transcript.promoter.gtf 

#Exercise 4 Use bedtools intersect to overlap TFs with promoters
module load biotools
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf \
-b tf.nfkb.bed > gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf

#Exercise 5 Use bedtools getfasta to extract sequences
module load biotools
bedtools getfasta -s -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta


#To submit a job for the PDAFM nodes, specify the pdafm queue. For example:

#PBS -q pdafm
#PBS -l nodes=2:np=20

#To reduce email load on the mailservers, please specify an email address in your TORQUE script. For example:

#PBS -l walltime=00:20:00
#PBS -M <your_username@ucsd.edu>
#PBS -m mail_options

#The following is an example of a TORQUE batch script for running an MPI job. The script lines are discussed in the comments that follow.

#!/bin/csh
#PBS -q <queue name>
#PBS -N <job name>
#PBS -l nodes=10:ppn=2
#PBS -l walltime=0:50:00
#PBS -o <output file>
#PBS -e <error file>
#PBS -V
#PBS -M <email address list>
#PBS -m abe
#PBS -A <account>

#PBS -q <queue name>
#PBS -N <job name>
#Specify the name of the job.

#PBS -l nodes=10:ppn=2
#Request 10 nodes and 2 processors per node.

#PBS -l walltime=0:50:00
#Reserve the requested nodes for 50 minutes.

#PBS -o <output file>
#Redirect standard output to a file.

#PBS -e <error file>
#Redirect standard error to a file.

#PBS -V
#Export all user environment variables to the job.

#PBS -M <email address list>
#List users, separated by commas, to receive email from this job.

#PBS -m abe
#Set of conditions under which the execution server will send email about the job: (a)bort, (b)egin, (e)nd.

#PBS -A <account>
