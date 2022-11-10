
#-------------------------------------------------------
# Aim：定量
# Author：zhangj
# update：2020-05-27
#-------------------------------------------------------


# -------------------1.featureCounts对bam文件进行计数
gtf=/home/jzhang/database/genome/Ensembl/Homo_sapiens/GRCh38_release95/Homo_sapiens.GRCh38.95.gtf.gz
inputdir=/home/jzhang/project/Human-16-Asthma-Trans/Analysis/Mapping/Hisat
outputdir=/home/jzhang/project/Human-16-Asthma-Trans/Analysis/Expression/featureCount

featureCounts -T 1 -p -t exon -g gene_id -a $gtf -o all.id.txt $inputdir/*.sorted.bam

multiqc all.id.txt.summary

cat all.id.txt | cut -f1,7- > counts.txt














