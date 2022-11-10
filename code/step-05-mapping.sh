
#-------------------------------------------------------
# Aim：比对
# Author：zhangj
# update：2020-05-27
#-------------------------------------------------------

## -----------1.参考基因组准备
# 下载，Ensembl：http://asia.ensembl.org/index.html
# ftp://ftp.ensembl.org/pub/release-95/fasta/homo_sapiens/dna/
# 基因组序列
wget ftp://ftp.ensembl.org/pub/release-95/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
wget ftp://ftp.ensembl.org/pub/release-95/gtf/homo_sapiens/Homo_sapiens.GRCh38.95.gtf.gz
# 转录组序列
wget ftp.ensembl.org/pub/release-95/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz

# 构建索引
cd /home/jzhang/database/genome/Ensembl/Homo_sapiens/GRCh38_release95
# hisat
hisat2-build Homo_sapiens.GRCh38_release95.genome.fa Homo_sapiens.GRCh38_release95.genome

# subjunc
subread-buildindex -o Homo_sapiens.GRCh38_release95.genome Homo_sapiens.GRCh38_release95.genome.fa

# 自己去下载索引



##------------ 2.比对:hisat2(http://ccb.jhu.edu/software/hisat/manual.shtml)
index=/home/jzhang/database/genome/Ensembl/Homo_sapiens/GRCh38_release95/Homo_sapiens.GRCh38_release95.genome
inputdir=/home/jzhang/project/Human-16-Asthma-Trans/data/cleandata/trim_galore
outdir=/home/jzhang/project/Human-16-Asthma-Trans/Analysis/Mapping/Hisat

# 比对
hisat2 -p 3  -x  ${index} -1 ${inputdir}/SRR1039508_1_val_1.fq.gz -2 ${inputdir}/SRR1039508_2_val_2.fq.gz -S ${outdir}/SRR1039510.Hisat_aln.sam

# sam转bam
samtools sort -@ 1 -o SRR1039508.Hisat_aln.sorted.bam SRR1039508.Hisat_aln.sam

# 对bam建索引
samtools index SRR1039508.Hisat_aln.sorted.bam SRR1039508.Hisat_aln.sorted.bam.bai

# 多个样本批量进行比对，排序，建索引
# Hisat.sh内容
cat /home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/sra/sra.id | while read id
do
	echo "hisat2 -p 3 -x ${index} -1 ${inputdir}/${id}_1_val_1.fq.gz -2 ${inputdir}/${id}_2_val_2.fq.gz 2>${id}.log  | samtools sort -@ 1 -o ${outdir}/${id}.Hisat_aln.sorted.bam -  && samtools index ${outdir}/${id}.Hisat_aln.sorted.bam ${outdir}/${id}.Hisat_aln.sorted.bam.bai"
done



##-------------3.比对：subjunc(http://subread.sourceforge.net/)
# subjunc单样本比对
index=/home/jzhang/database/genome/Ensembl/Homo_sapiens/GRCh38_release95/Homo_sapiens.GRCh38_release95.genome
inputdir=/home/jzhang/project/Human-16-Asthma-Trans/data/cleandata/trim_galore
outdir=/home/jzhang/project/Human-16-Asthma-Trans/Analysis/Mapping/Subjunc

subjunc -T 1 -i ${index} -r ${inputdir}/SRR1039508_1_val_1.fq.gz -R ${inputdir}/SRR1039508_2_val_2.fq.gz -o ${outdir}/SRR1039508.Subjunc.bam 1>${outdir}/SRR1039508.Subjunc.log 2>&1

# subjunc多样本比对
cat /home/jzhang/project/Human-16-Asthma-Trans/data/rawdata/sra/sra.id | while read id
do
	echo "subjunc -T 1 -i ${index} -r ${inputdir}/${id}_1_val_1.fq.gz -R ${inputdir}/${id}_2_val_2.fq.gz -o ${outdir}/${id}.Subjunc.bam 1>${outdir}/${id}.Subjunc.log 2>&1 | samtools sort -@ 1 -o ${outdir}/${id}.Subjunc.sorted.bam  ${outdir}/${id}.Subjunc.bam && samtools index ${outdir}/${id}.Subjunc.sorted.bam ${outdir}/${id}.Subjunc.sorted.bam.bai "
done






